# Phase 03 - Canonical Snapshot

## Objective
Build reproducible canonical snapshots from raw data with strict schema contracts.

## Scope
Transform raw ingestion outputs into structured, versioned snapshots stored locally (e.g., Parquet/DuckDB) with validation.

## Inputs
- Validated raw data and provenance logs
- Snapshot schema contract

## Outputs
- Canonical snapshot files with version and checksum

## Artifact
CLI to convert raw → canonical snapshot, emitting validation reports and checksums.

## Acceptance
- Snapshot adheres to `snapshot_schema` contract.
- Re-running with same inputs yields identical outputs and checksums.
- Validation reports are stored alongside snapshots.

## Commands
- `./scripts/build_snapshot.sh --date YYYY-MM-DD`
- `duckdb :memory: "SELECT COUNT(*) FROM 'data/snapshots/*.parquet'"`

## Do Not Build Yet
Feature calculations, classification, scoring, ML, reporting, or orchestration.

## Allowed Paths
`scripts/`, `data/snapshots/`, `docs/CONTRACTS/snapshot_schema.md`, `docs/PHASES/03_snapshot.md`

## Failure Modes
- Schema drift not caught by validation.
- Untracked parameters leading to non-reproducibility.
- Mixing transformation logic intended for later phases.
