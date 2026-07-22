---
name: fastpath
description: Minimize plan reads with task fast paths and indexes
---

# Fast Path For Plan Docs

## Goal

Minimize routine plan reads while keeping plan state exact.

## Routine Path

Use for ordinary progress on an already planned task.

1. Read `SNAPSHOTS.md`.
2. If it gives `plan_readme`, `detail_file`, `heading` or `anchor`, and next task info, trust those fields; do not rediscover the task.
3. Read only the selected plan README status/current/next lines and the current task section or bounded heading snippet.
4. Apply the update, then do not reopen plan docs just to summarize.
5. This choice is internal; do not ask the user whether to use the fast path.

## Discovery Path

Use only when routine fields are missing or conflict.

- Exact local link: open it directly.
- Id/title only: one bounded `rg -n` over plan indexes/headings, then the matching section.
- Unknown task: read `docs/plans/README.md`, selected plan README, then required detail only.
- Do not read unrelated plans, completed history, phase overviews, full detail files, or `docs/AGENTS.md` during routine progress unless the missing fact requires it.

## Write

- Update only the affected task, selected plan README row/status, `Current task`/`Next task`, and `SNAPSHOTS.md`.
- Keep `SNAPSHOTS.md` canonical with objective, current/next task links, `plan_readme`, `detail_file`, `heading` or `anchor`, blockers, latest verification, and archive.
- If `HANDOFF.md` exists, keep only compact links to `SNAPSHOTS.md` and current task. Do not create it for compatibility.
- Keep full build logs out of plan docs and replies; report status, counts, and bounded failure excerpts.

## References

- Read [references/init-and-migration.md](references/init-and-migration.md) only for `fastpath init`, contract installation, or migration.
- Read [references/plan-contract.md](references/plan-contract.md) only for creating, splitting, restructuring, or structural checks.
- Read [references/language-policy.md](references/language-policy.md) only for document creation, label/name changes, or language choice.
- Do not load references during routine progress unless required.

## Verification

- Routine: use the narrow project helper if present; otherwise check affected Markdown links and `git diff --check`.
- Structural: also confirm each plan has `README.md`, `active/`, `completed/`, completed details live under `completed/`, and `docs/AGENTS.md` has the contract.
- Summarize verification; do not paste successful full logs.
