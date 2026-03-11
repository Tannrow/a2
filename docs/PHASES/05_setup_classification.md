# Phase 05 - Setup Classification and No-Trade Gate

## Objective
Classify feature sets into trading setups and explicit no-trade outcomes using deterministic rules.

## Scope
Rule-based classifiers that consume features, apply gating, and emit labeled setups with rationale.

## Inputs
- Feature tables
- Setup classification rules
- No-trade gate criteria

## Outputs
- Labeled setups and no-trade records with rationale and metadata

## Artifact
CLI that reads features, applies classification and no-trade gating, and writes labeled outputs conforming to `setup_schema`.

## Acceptance
- Classifications repeatable with identical inputs.
- No-trade outputs are logged with reasons.
- Rationale captured per label for auditability.

## Commands
- `./scripts/classify_setups.sh --date YYYY-MM-DD`
- `duckdb :memory: "SELECT label, COUNT(*) FROM 'data/setups/*.parquet' GROUP BY 1"`

## Do Not Build Yet
Scoring, trade hypothesis generation, ML, reporting, or orchestration.

## Allowed Paths
`scripts/`, `data/setups/`, `docs/CONTRACTS/setup_schema.md`, `docs/PHASES/05_setup_classification.md`

## Failure Modes
- Gating rules ignored or inconsistently applied.
- Missing rationale fields for labels/no-trade decisions.
- Hidden stochastic elements creeping into classification.
