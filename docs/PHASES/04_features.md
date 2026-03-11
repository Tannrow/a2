# Phase 04 - Feature Engineering

## Objective
Generate deterministic feature sets from canonical snapshots with explicit definitions.

## Scope
Define feature formulas, compute them reproducibly, and store them with schema and versioning.

## Inputs
- Canonical snapshots
- Feature schema contract
- Feature definitions and parameters

## Outputs
- Feature tables with metadata, checksums, and validation reports

## Artifact
CLI that reads snapshots and produces feature tables conforming to `feature_schema` with logged run parameters.

## Acceptance
- Features match contract; unit calculations deterministic across runs.
- Definitions documented with lineage to snapshot fields.
- Validation and checksum recorded alongside outputs.

## Commands
- `./scripts/build_features.sh --date YYYY-MM-DD`
- `duckdb :memory: "SELECT * FROM 'data/features/*.parquet' LIMIT 5"`

## Do Not Build Yet
Classification logic, scoring, ML models, reporting, or orchestration.

## Allowed Paths
`scripts/`, `data/features/`, `docs/CONTRACTS/feature_schema.md`, `docs/PHASES/04_features.md`

## Failure Modes
- Silent changes to feature formulas.
- Missing documentation of feature lineage.
- Non-deterministic computations (e.g., floating time windows without anchoring).
