# Prediction Log Schema Contract

## Purpose
Define append-only prediction log entries for hypotheses and no-trade outcomes, enabling evaluation and calibration.

## Required Fields
- `as_of`: ISO date for decision.
- `symbol`: ticker string.
- `hypothesis_id`: reference to hypothesis or `no_trade` entry.
- `decision`: one of `enter`, `no_trade`, `abstain`.
- `inputs_reference`: identifiers for snapshot/feature/setup/score runs.
- `timestamp`: time the decision was logged.
- `checksum`: hash of log entry.

## Optional Fields
- `realized_outcome`: later-attached result metrics (e.g., return, max_drawdown).
- `notes`: array of strings for anomalies.

## Determinism and Traceability
- Entries are append-only; updates create new entries with linkage to prior.
- Decisions must reference deterministic inputs; no LLM-only decisions.

## Example JSON Stub
```json
{
  "as_of": "2026-03-10",
  "symbol": "AAPL",
  "hypothesis_id": "hypo-20260310-01",
  "decision": "enter",
  "inputs_reference": {
    "snapshot_run_id": "snapshot-20260310-001",
    "feature_run_id": "features-20260310-001",
    "setup_run_id": "setup-20260310-001",
    "score_run_id": "score-20260310-001"
  },
  "timestamp": "2026-03-10T21:30:00Z",
  "checksum": "sha256:pqr678",
  "realized_outcome": {
    "return_pct": 1.2,
    "max_drawdown_pct": -0.6,
    "holding_days": 3
  },
  "notes": ["Exited early due to event"]
}
```

## Validation Expectations
- Enforce append-only semantics.
- Verify references exist and checksums align.
- Ensure decisions stay within allowed set and timestamps are ordered.
