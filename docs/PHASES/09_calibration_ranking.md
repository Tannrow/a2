# Phase 09 - Calibration and Ranking

## Objective
Calibrate scores and rank hypotheses based on historical evaluation to improve decision quality.

## Scope
Apply calibration techniques to deterministic scores, adjust weights, and produce ranked lists with audit trails.

## Inputs
- Evaluation outputs
- Historical scores and hypotheses
- Calibration parameters

## Outputs
- Calibrated scores and ranked hypothesis lists with metadata

## Artifact
CLI that calibrates scores and emits ranked outputs with versioned parameters.

## Acceptance
- Calibration methods and parameters documented and versioned.
- Re-running with same inputs yields identical calibrated results.
- Ranking rationale is traceable to calibrated scores.

## Commands
- `./scripts/calibrate_scores.sh --as-of YYYY-MM-DD`
- `./scripts/rank_hypotheses.sh --as-of YYYY-MM-DD`

## Do Not Build Yet
Orchestration or deployment pipelines; new feature or scoring logic.

## Allowed Paths
`scripts/`, `data/calibrated/`, `data/rankings/`, `docs/PHASES/09_calibration_ranking.md`

## Failure Modes
- Unversioned parameter changes.
- Rankings detached from calibrated evidence.
- Introducing stochastic ML before deterministic calibration baselines.
