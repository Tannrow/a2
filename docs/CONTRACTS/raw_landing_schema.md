# Raw Landing Schema Contract

## Purpose
Define the raw landing format produced by Phase 02 ingestion, including the sidecar provenance record used for reproducibility and checksum verification.

## File Layout
- Raw payload files live under `data/raw/<source>/<YYYY-MM-DD>/<symbol>.json`.
- Provenance sidecars live beside the raw payload as `data/raw/<source>/<YYYY-MM-DD>/<symbol>.provenance.json`.
- Ingestion logs live under `data/raw/logs/`.

## Raw Payload Required Fields
- `vendor`: source identifier used for the fetch.
- `request`: object containing the request parameters used to obtain the raw payload.
- `request.date`: ISO date requested from the source.
- `request.symbol`: ticker symbol requested from the source.
- `data`: source-native payload body stored without downstream normalization.
- `data.symbol`: ticker symbol echoed by the source.
- `data.as_of`: ISO date for the end-of-day record.
- `data.bar`: object containing a single end-of-day OHLCV record.
- `data.bar.timestamp`: timestamp string for the end-of-day bar.
- `data.bar.open`: opening price.
- `data.bar.high`: high price.
- `data.bar.low`: low price.
- `data.bar.close`: closing price.
- `data.bar.volume`: traded volume.

## Provenance Required Fields
- `schema_version`: version of this landing contract.
- `source_name`: source identifier used for the fetch.
- `fetch_timestamp`: ISO 8601 timestamp recorded for the fetch event.
- `fetch_parameters`: object containing the date, source, and symbol used for the fetch.
- `raw_file`: relative path to the raw payload file.
- `checksum`: SHA-256 checksum of the raw payload file bytes.

## Optional Fields
- `quality_flags`: array of validation warnings that do not invalidate the raw file.
- `notes`: free-form notes about the landed payload.

## Determinism and Traceability
- Re-running ingestion with the same source, date, and symbol set must produce identical raw payload bytes and checksum values.
- The provenance sidecar must be sufficient to identify the exact payload file and re-compute its checksum.
- Raw landing stores source-shaped data only; canonical normalization belongs to later phases.

## Example JSON Stub
```json
{
  "vendor": "mock_vendor",
  "request": {
    "date": "2026-03-10",
    "symbol": "AAPL"
  },
  "data": {
    "symbol": "AAPL",
    "as_of": "2026-03-10",
    "bar": {
      "timestamp": "2026-03-10T21:00:00Z",
      "open": 170.12,
      "high": 172.44,
      "low": 169.75,
      "close": 171.98,
      "volume": 12003456
    }
  }
}
```

```json
{
  "schema_version": "1.0",
  "source_name": "mock_vendor",
  "fetch_timestamp": "2026-03-10T21:00:00Z",
  "fetch_parameters": {
    "date": "2026-03-10",
    "source": "mock_vendor",
    "symbol": "AAPL"
  },
  "raw_file": "data/raw/mock_vendor/2026-03-10/AAPL.json",
  "checksum": "sha256:abc123"
}
```

## Validation Expectations
- Validate the CLI arguments before landing files.
- Assert required fields exist in both the raw payload and provenance sidecar.
- Verify that the stored checksum matches the raw payload file bytes after writing.
- Reject unsupported sources or invalid date formats rather than silently altering inputs.
