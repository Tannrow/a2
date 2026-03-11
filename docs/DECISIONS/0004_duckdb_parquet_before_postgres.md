# ADR 0004: DuckDB/Parquet Before Postgres


## Status
Accepted

## Context
Early phases need lightweight, local, reproducible storage without infrastructure overhead.

## Decision
Use DuckDB with Parquet files for snapshots, features, and intermediate tables before considering Postgres or cloud databases.

## Consequences
Simplifies setup and reproducibility; limits concurrency and remote access. Migration to Postgres requires later justification and migration plan.
