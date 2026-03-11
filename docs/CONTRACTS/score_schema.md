# Score Schema Contract

## Purpose
Standardize deterministic scoring outputs derived from classified setups.

## Required Fields
- `as_of`: ISO date.
- `symbol`: ticker string.
- `setup_run_id`: reference to setup classification run.
- `scorecard_version`: identifier for scoring ruleset.
- `score`: numeric value representing trade quality.
- `factors`: list of factor contributions with `name`, `weight`, `value`, and `contribution`.
- `checksum`: hash of score payload.

## Optional Fields
- `confidence_band`: deterministic interval if applicable.
- `notes`: array of explanatory strings.

## Determinism and Traceability
- Factor weights and formulas must be versioned; changes require new scorecard_version.
- Scores recomputed with same inputs must match checksum.

## Example JSON Stub
```json
{
  "as_of": "2026-03-10",
  "symbol": "AAPL",
  "setup_run_id": "setup-20260310-001",
  "scorecard_version": "scorecard-v1",
  "score": 0.64,
  "factors": [
    {"name": "trend_strength", "weight": 0.4, "value": 0.7, "contribution": 0.28},
    {"name": "volatility_filter", "weight": 0.3, "value": 0.5, "contribution": 0.15}
  ],
  "checksum": "sha256:jkl012",
  "confidence_band": [0.55, 0.70],
  "notes": ["Volume filter capped"]
}
```

## Validation Expectations
- Verify factor list sums to intended weighting scheme.
- Check score reproducibility and checksum integrity.
- Ensure linkage back to setup run is present.
