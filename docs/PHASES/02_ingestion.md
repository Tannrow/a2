# Phase 02 - Raw Ingestion

## Objective
Create deterministic end-of-day raw data ingestion with provenance tracking.

## Scope
Fetch raw market data, store it with checksums and metadata, and log source details.

## Inputs
- Source configurations
- End-of-day data endpoints or files

## Outputs
- Raw landing files with provenance and checksums

## Artifact
CLI command that fetches and stores raw data to a controlled directory with logs.

## Acceptance
- Ingestion run reproducibly fetches data and writes checksummed files.
- Provenance (source, time, parameters) is logged.
- No transformation beyond minimal validation.

## Commands
- `./scripts/ingest_raw.sh --date YYYY-MM-DD` (placeholder)
- `find data/raw -type f`

## Do Not Build Yet
Canonical snapshots, feature generation, classification, scoring, ML, dashboards, or orchestration.

## Allowed Paths
`scripts/`, `data/raw/`, `docs/CONTRACTS/`, `docs/PHASES/02_ingestion.md`

## Failure Modes
- Implicit transformations altering raw data.
- Missing provenance metadata.
- Non-deterministic fetching due to floating endpoints.
