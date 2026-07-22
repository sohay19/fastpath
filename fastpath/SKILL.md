---
name: fastpath
description: Minimize plan reads with task fast paths and indexes
---

# Fast Path For Plan Docs

## Goal

Minimize plan-reading tokens while keeping plan state discoverable and correct.

## Read Workflow

1. If an exact task path, id, or title is known, use the Known Task Fast Path.
2. Otherwise read `docs/plans/README.md`, then the selected plan `README.md`, then only required detail content.
3. Do not load unrelated plan files or completed history.
4. Reuse already-read project instructions; do not reread `docs/AGENTS.md` during a routine task update unless it changed or structural compliance is in doubt.

## Known Task Fast Path

- If an exact local task link is supplied by the user, `SNAPSHOTS.md`, an existing `HANDOFF.md`, or a plan README, open that target directly.
- If only an id or title is known, locate it with `rg -n` in plan indexes and headings before reading content.
- For a task inside a large detail file, read from its heading to the next heading of the same or higher level.
- Expand context in small bounded ranges only when a referenced prerequisite is missing.
- Do not read the whole detail file unless the task depends on document-wide rules that are unavailable in the plan README.

## Write Workflow

- Change only the affected task section, its plan index row, and `Current task`/`Next task` links when state changes.
- Keep detailed implementation history in the plan detail; do not duplicate it in status snapshots.
- Keep `SNAPSHOTS.md` as the canonical current-state snapshot: objective, current/next task links, blockers, latest verification, and an archive link.
- If `HANDOFF.md` already exists, preserve it and update only a compact plan-status note containing links to `SNAPSHOTS.md` and the current task, plus blockers when present. Do not create `HANDOFF.md` solely for this compatibility path or copy detailed implementation history into it.
- Keep full build logs out of conversational context and plan docs. Return only exit status, warning/error counts, and task-relevant matches; inspect bounded failure excerpts when needed.
- Prefer targeted checks before broad builds, while following explicit project or user verification requirements.

## Size Guard

- Treat a detail file over 400 lines or over 10 task headings as oversized.
- For new content, split oversized details by the granularity rules in [references/plan-contract.md](references/plan-contract.md).
- For existing oversized content, keep using the section fast path and ask before restructuring unless the user already authorized it.

## Conditional References

- Read [references/init-and-migration.md](references/init-and-migration.md) only for `fastpath init`, contract installation, or existing-plan migration.
- Read [references/plan-contract.md](references/plan-contract.md) only when creating, splitting, restructuring, or checking structural compliance.
- Read [references/language-policy.md](references/language-policy.md) only when creating documents, changing labels/names, or resolving a language preference.
- Do not load a reference that the current task does not require.

## Verification

- For routine task updates, validate affected local Markdown links and run `git diff --check` in a git repo.
- For structural work, also confirm every plan has `README.md`, `active/`, and `completed/`; completed details are under `completed/`; and `docs/AGENTS.md` contains the active contract.
- Summarize verification results; do not paste successful full logs.
