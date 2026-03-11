# AGENTS: Repository Constitution

This repository builds a private, CLI-first ticker intelligence and trade-probability system. Version 1 is end-of-day only. Deterministic scoring precedes any ML; LLM usage is limited to synthesis, evidence aggregation, scenario narration, and report writing, never sole decisioning.

## Operating Boundaries
- CLI-only; no browser UI or dashboard. Keep outputs text-first with optional static artifacts.
- End-of-day processing only; no intraday or real-time features in early phases.
- Deterministic/statistical signals before any ML; ML can only be considered after deterministic checkpoints pass.
- LLMs support summarization and reporting, not gating, scoring, or execution decisions.
- Each phase must end with a runnable artifact and a hard pass/fail checkpoint before advancing.
- Forbidden in early phases: vector databases, multi-agent systems, sentiment pipelines, auto-trading, intraday feeds, dashboards, or speculative UI scaffolding.

## Phase Discipline
- Current phase is recorded in `docs/CURRENT_PHASE.md`; Codex must operate only within that phase and the task in `NEXT_TASK.md`.
- If a request conflicts with the current phase or task, stop and report the conflict.
- Prefer small, incremental PRs that keep the repository clear and easy to audit.
- Do not modify unrelated files; keep scope aligned to the active task and phase boundaries.

## Checkpoints and Artifacts
- Every phase produces a concrete runnable/checkable artifact (script, schema, CLI command, or documented procedure) and explicit acceptance checks.
- If acceptance checks fail, do not claim completion and do not advance the phase.
- Preserve determinism, traceability, and reproducibility at all times; avoid over-engineering and unnecessary dependencies.

## Enforcement
- If phase boundaries, forbidden work, or acceptance criteria are unclear, request clarification before proceeding.
- Report blockers early. Stop work when encountering scope drift or tasks that authorize UI, intraday, auto-trading, or ML decisioning too early.
