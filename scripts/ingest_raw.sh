#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'EOF'
Usage: ./scripts/ingest_raw.sh --date YYYY-MM-DD [--source mock_vendor]

Environment overrides:
  INGEST_SYMBOLS            Comma-separated symbol list (default: AAPL,MSFT,SPY)
  INGEST_FETCH_TIMESTAMP    ISO 8601 timestamp override for provenance
EOF
}

DATE=""
SOURCE="mock_vendor"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --date)
      DATE="${2:-}"
      shift 2
      ;;
    --source)
      SOURCE="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ -z "$DATE" ]]; then
  echo "--date is required" >&2
  usage >&2
  exit 1
fi

if [[ ! "$DATE" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
  echo "Invalid --date format: $DATE" >&2
  exit 1
fi

if [[ "$SOURCE" != "mock_vendor" ]]; then
  echo "Unsupported --source: $SOURCE" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

export INGEST_DATE="$DATE"
export INGEST_SOURCE="$SOURCE"
export INGEST_SYMBOLS="${INGEST_SYMBOLS:-AAPL,MSFT,SPY}"
export INGEST_FETCH_TIMESTAMP="${INGEST_FETCH_TIMESTAMP:-${DATE}T21:00:00Z}"
export REPO_ROOT

python3 - <<'PY'
import datetime as dt
import hashlib
import json
import os
from pathlib import Path

repo_root = Path(os.environ["REPO_ROOT"])
date = os.environ["INGEST_DATE"]
source = os.environ["INGEST_SOURCE"]
symbols = [symbol.strip().upper() for symbol in os.environ["INGEST_SYMBOLS"].split(",") if symbol.strip()]
fetch_timestamp = os.environ["INGEST_FETCH_TIMESTAMP"]

if not symbols:
    raise SystemExit("INGEST_SYMBOLS must contain at least one symbol")

try:
    dt.date.fromisoformat(date)
except ValueError as exc:
    raise SystemExit(f"Invalid date: {date}") from exc

try:
    dt.datetime.fromisoformat(fetch_timestamp.replace("Z", "+00:00"))
except ValueError as exc:
    raise SystemExit(f"Invalid INGEST_FETCH_TIMESTAMP: {fetch_timestamp}") from exc

raw_dir = repo_root / "data" / "raw" / source / date
log_dir = repo_root / "data" / "raw" / "logs"
raw_dir.mkdir(parents=True, exist_ok=True)
log_dir.mkdir(parents=True, exist_ok=True)

log_path = log_dir / f"ingest_{date}.log"
log_lines = [
    f"{fetch_timestamp} START source={source} date={date} symbols={','.join(symbols)}"
]

def deterministic_bar(as_of: str, vendor: str, symbol: str) -> dict:
    seed = hashlib.sha256(f"{as_of}:{vendor}:{symbol}".encode("utf-8")).digest()
    numbers = [int.from_bytes(seed[index:index + 4], "big") for index in range(0, 20, 4)]
    open_price = round(80 + (numbers[0] % 120) + ((numbers[1] % 100) / 100), 2)
    close_delta = ((numbers[2] % 1001) - 500) / 100
    close_price = round(max(1.0, open_price + close_delta), 2)
    high_price = round(max(open_price, close_price) + ((numbers[3] % 401) / 100), 2)
    low_price = round(max(0.01, min(open_price, close_price) - ((numbers[4] % 401) / 100)), 2)
    volume = 1_000_000 + (numbers[0] % 9_000_000)
    return {
        "timestamp": f"{as_of}T21:00:00Z",
        "open": open_price,
        "high": high_price,
        "low": low_price,
        "close": close_price,
        "volume": volume,
    }

for symbol in symbols:
    payload = {
        "vendor": source,
        "request": {
            "date": date,
            "symbol": symbol,
        },
        "data": {
            "symbol": symbol,
            "as_of": date,
            "bar": deterministic_bar(date, source, symbol),
        },
    }

    raw_path = raw_dir / f"{symbol}.json"
    raw_bytes = (json.dumps(payload, indent=2, sort_keys=True) + "\n").encode("utf-8")
    raw_path.write_bytes(raw_bytes)

    checksum = hashlib.sha256(raw_bytes).hexdigest()
    provenance = {
        "schema_version": "1.0",
        "source_name": source,
        "fetch_timestamp": fetch_timestamp,
        "fetch_parameters": {
            "date": date,
            "source": source,
            "symbol": symbol,
        },
        "raw_file": raw_path.relative_to(repo_root).as_posix(),
        "checksum": f"sha256:{checksum}",
    }

    if os.environ.get("INGEST_QUALITY_FLAGS"):
        provenance["quality_flags"] = [
            flag.strip() for flag in os.environ["INGEST_QUALITY_FLAGS"].split(",") if flag.strip()
        ]

    expected_payload_keys = {"vendor", "request", "data"}
    if set(payload) != expected_payload_keys:
        raise SystemExit(f"Payload keys invalid for {symbol}: {sorted(payload)}")
    if set(provenance) < {"schema_version", "source_name", "fetch_timestamp", "fetch_parameters", "raw_file", "checksum"}:
        raise SystemExit(f"Provenance keys invalid for {symbol}: {sorted(provenance)}")

    actual_checksum = hashlib.sha256(raw_path.read_bytes()).hexdigest()
    if actual_checksum != checksum:
        raise SystemExit(f"Checksum mismatch for {symbol}: expected {checksum}, got {actual_checksum}")

    provenance_path = raw_dir / f"{symbol}.provenance.json"
    provenance_path.write_text(json.dumps(provenance, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    log_lines.append(f"{fetch_timestamp} WROTE symbol={symbol} checksum=sha256:{checksum}")

log_lines.append(f"{fetch_timestamp} COMPLETE source={source} date={date} count={len(symbols)}")
log_path.write_text("\n".join(log_lines) + "\n", encoding="utf-8")

print(f"Wrote {len(symbols)} raw payloads to {raw_dir.relative_to(repo_root).as_posix()}")
print(f"Wrote log to {log_path.relative_to(repo_root).as_posix()}")
PY
