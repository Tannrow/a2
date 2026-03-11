# Feature Schema Contract

## Purpose
Define deterministic feature outputs derived from canonical snapshots for setup classification.

## Required Fields
- `as_of`: ISO date tied to snapshot.
- `symbol`: ticker string.
- `snapshot_run_id`: link to snapshot used.
- `feature_set`: name/version of feature bundle.
- `features`: key-value map of feature names to numeric/string values.
- `lineage`: description of source fields per feature.
- `checksum`: hash of feature payload.

## Optional Fields
- `window_params`: lookback windows and parameters used.
- `quality_flags`: array describing data quality checks.

## Determinism and Traceability
- Feature computations must be pure functions of the snapshot and documented parameters.
- Store lineage and parameters to reproduce identical outputs.

## Example JSON Stub
```json
{
  "as_of": "2026-03-10",
  "symbol": "AAPL",
  "snapshot_run_id": "snapshot-20260310-001",
  "feature_set": "v1.0",
  "features": {
    "sma_20": 169.4,
    "sma_50": 165.2,
    "rsi_14": 58.3
  },
  "lineage": {
    "sma_20": "close prices last 20 trading days",
    "rsi_14": "14-day RSI on close"
  },
  "checksum": "sha256:def456",
  "window_params": {
    "sma_windows": [20, 50],
    "rsi_length": 14
  },
  "quality_flags": ["no_missing_values"]
}
```

## Validation Expectations
- Schema/type checks; feature names match registry.
- Parameter hashing to ensure reproducibility.
- Spot-check deterministic recompute vs stored checksum.
