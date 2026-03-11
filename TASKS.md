# Task System

## How Tasks Are Structured
- Tasks live under `tasks/<phase>/task_<nn>_*.yaml` with clear objectives, inputs, outputs, allowed/forbidden paths, commands, acceptance, and stop conditions.
- `NEXT_TASK.md` contains exactly one executable task path. `STATUS.md` summarizes progress.

## Execution Rules for Codex
- Read `AGENTS.md`, `docs/CURRENT_PHASE.md`, and `NEXT_TASK.md` before work.
- Operate only within the current phase and the single task in `NEXT_TASK.md` unless explicitly advanced.
- If a request conflicts with the phase/task, stop and report.

## Phase/Task Boundaries
- Do not start tasks from future phases without human approval and phase advancement.
- Keep changes scoped to `allowed_paths`; never touch `forbidden_paths`.

## Acceptance Discipline
- Use task `acceptance` items as pass/fail checks before claiming completion.
- If acceptance fails, do not mark tasks complete or advance phases.

## Updating Status
- After completing a task, append it to completed tasks in `STATUS.md`, update pending items, and refresh `last updated`.
- Update `NEXT_TASK.md` to the next approved task in sequence.

## If Blocked
- Document blockers in `STATUS.md` under blockers.
- Stop work if blockers relate to phase conflicts or forbidden scope and request guidance.
