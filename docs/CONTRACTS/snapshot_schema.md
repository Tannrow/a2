# Snapshot Schema Contract

## Purpose
Define the canonical snapshot format produced from raw ingestion for reproducible downstream processing.

## Required Fields
- `as_of`: ISO date of snapshot.
- `symbol`: ticker string.
- `source`: data provider identifier.
- `timezone`: IANA timezone.
- `currency`: quote currency.
- `bars`: array of OHLCV objects with `timestamp`, `open`, `high`, `low`, `close`, `volume`.
- `checksum`: hash of raw inputs used to build snapshot.
- `run_id`: unique identifier for the build run.

## Optional Fields
- `adjustment`: split/dividend adjustment flag.
- `notes`: array of strings for anomalies.

## Determinism and Traceability
- Snapshot must be derived solely from recorded raw files and parameters.
- Checksums stored alongside outputs; re-running with same inputs yields identical hashes.

## Example JSON Stub
```json
{
  "as_of": "2026-03-10",
  "symbol": "AAPL",
  "source": "example_vendor",
  "timezone": "America/New_York",
  "currency": "USD",
  "bars": [
    {
      "timestamp": "2026-03-10T16:00:00-05:00",
      "open": 170.1,
      "high": 172.0,
      "low": 169.5,
      "close": 171.8,
      "volume": 12003456
    }
  ],
  "checksum": "sha256:abc123",
  "run_id": "snapshot-20260310-001",
  "adjustment": "split-adjusted",
  "notes": ["partial trading day"]
}
```

## Validation Expectations
- Schema validation against required fields and types.
- Checksum verification between raw inputs and snapshot outputs.
- Assert non-empty bars and ordered timestamps.
