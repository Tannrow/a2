# Phase 08 - Prediction Log and Evaluation

## Objective
Maintain an append-only prediction log and evaluate performance of hypotheses and no-trade decisions.

## Scope
Record predictions, outcomes, and run evaluations with deterministic metrics.

## Inputs
- Trade hypotheses and scores
- No-trade decisions
- Realized outcomes data

## Outputs
- Append-only prediction log
- Evaluation metrics and reports

## Working Artifact
CLI to append to prediction log and run evaluation metrics over historical records.

## Acceptance Criteria
- Logs are append-only with timestamps and references to inputs.
- Evaluation metrics reproducible and documented.
- No-trade outcomes included in evaluation.

## Example Commands
- `./scripts/update_prediction_log.sh --date YYYY-MM-DD`
- `./scripts/evaluate_predictions.sh --since 2026-01-01`

## Do Not Build Yet
Calibration/ranking, orchestration, or UI/dashboard layers.

## Likely Paths Touched
`logs/predictions/`, `reports/evaluation/`, `docs/CONTRACTS/prediction_schema.md`, `docs/PHASES/08_evaluation.md`

## Common Failure Modes
- Mutating historical log entries.
- Ignoring no-trade cases in metrics.
- Metrics that are non-deterministic or poorly specified.
