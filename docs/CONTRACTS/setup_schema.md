# Setup Classification Schema Contract

## Purpose
Describe labeled setups and no-trade decisions produced from feature sets.

## Required Fields
- `as_of`: ISO date.
- `symbol`: ticker string.
- `feature_run_id`: reference to feature generation run.
- `label`: setup label or `no_trade`.
- `rationale`: structured text explaining rule triggers.
- `rules_fired`: list of rule identifiers applied.
- `checksum`: hash of classification payload.

## Optional Fields
- `risk_tags`: list of risk flags (e.g., "low_liquidity").
- `confidence`: optional deterministic score for classification confidence.

## Determinism and Traceability
- Rule evaluation must be deterministic; rules and parameters must be versioned.
- No-trade outcomes logged with reasons equivalent to trade setups.

## Example JSON Stub
```json
{
  "as_of": "2026-03-10",
  "symbol": "AAPL",
  "feature_run_id": "features-20260310-001",
  "label": "breakout_pullback",
  "rationale": "Close above resistance with declining volume during pullback",
  "rules_fired": ["breakout_above_resistance", "volume_decline_pullback"],
  "checksum": "sha256:ghi789",
  "risk_tags": ["elevated_volatility"],
  "confidence": 0.72
}
```

## Validation Expectations
- Ensure label exists in controlled taxonomy.
- Verify rules_fired non-empty and parameters recorded.
- Checksum matches deterministic recompute of payload.
