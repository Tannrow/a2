# Current Phase

**Phase 02 - Raw Ingestion**

- Phase goal: create deterministic end-of-day raw data ingestion with provenance tracking.
- Allowed objectives: fetch raw market data from configured sources, store it with checksums and metadata, and log source details with minimal validation only.
- Required artifact: a CLI command that fetches and stores raw data to a controlled directory with logs.
- Exit checkpoint: ingestion runs reproducibly, writes checksummed raw files, records provenance, and avoids transformations beyond minimal validation.
- Forbidden right now: canonical snapshots, feature generation, classification, scoring, ML, dashboards, orchestration, intraday, auto-trading, vector databases, or agent frameworks.
- Codex behavior: stay inside Phase 02 scope and the single task in NEXT_TASK.md; keep changes deterministic and auditable; stop if asked to implement later-phase work.
