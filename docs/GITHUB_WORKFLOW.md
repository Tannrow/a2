# GitHub Workflow Guidance

## Reading the Guardrails
1. Open `AGENTS.md` for constitution and forbidden work.
2. Read `docs/CURRENT_PHASE.md` to confirm scope and allowed objectives.
3. Check `NEXT_TASK.md` for the single executable task.

## Small PR Flow
- Keep changes narrow and phase-scoped; avoid large batches.
- Update only files listed in allowed paths for the active task.
- Document progress in `STATUS.md` and move `NEXT_TASK.md` only after acceptance is met.

## Phase Gates
- Do not advance phases without explicit checkpoint success and human approval.
- Each phase requires a runnable artifact and pass/fail checks recorded in docs.

## Task Chaining
- Complete the current task, update status, then set `NEXT_TASK.md` to the next task in order.
- If blocked, log the blocker in `STATUS.md` and pause.

## Human Approval
- Request review before changing phases, altering ADRs, or expanding scope (e.g., UI, ML, intraday, vector DBs).

## Status Updates
- After task completion, refresh `STATUS.md` (completed/pending/blockers, last updated) and adjust `NEXT_TASK.md`.
- Ensure updates remain consistent with `AGENTS.md` and `docs/CURRENT_PHASE.md`.
