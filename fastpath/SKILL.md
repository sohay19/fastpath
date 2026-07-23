---
name: fastpath
description: Minimize plan-reading cost with low-context task fast paths, behavior rules, and indexes
---

# Fast Path For Plan Docs

## Goal

Reduce actual model cost by changing routine behavior: read less, search less, repeat less, and write shorter outputs while preserving plan correctness.

Do not calculate benchmark cost unless project-specific benchmark instructions ask for it. Cost formulas, prices, and success judgments belong to the project or runner; this skill only provides cost-saving behavior rules.

## Cost-Saving Rules

- Trust a valid routine Fast Path instead of rediscovering task location.
- Prefer `task_id` and `line_start`/`line_end`; if a line range exists, do not search headings or read neighboring tasks.
- Read the smallest sufficient document slice, then stop reading.
- Treat references as conditional; load them only for init, migration, restructuring, or explicit missing facts.
- Keep persistent plan/snapshot text compact. Do not add benchmark formulas or long policy explanations unless the project asks.
- Keep final replies short and inside the recorded response budget.

## Routine

For ordinary progress on a known planned task:

1. Read `SNAPSHOTS.md` once.
2. If `## Fast Path` has `mode: routine`, `plan_readme`, `detail_file`, `task_id` or `heading`/`anchor`, next task info, and preferably `line_start`/`line_end`, trust it. Do not rediscover.
3. Read only the plan README top state block and the detail line range. If no range exists, read only the exact current heading section.
4. Apply the update, including current/next task and line-range maintenance when needed.
5. Run only narrow verification, then do not reread docs just to summarize.
6. Final reply: task/result, verification id, exact/protocol if known. No document recap or success log.

## Discovery

Use only when Fast Path fields are missing or conflict.

- Exact link: open it.
- Id/title only: one bounded `rg -n` over indexes/headings, then the matching section.
- Unknown task: read `docs/plans/README.md`, selected plan README state block, then one required detail.
- Do not read unrelated plans, completed history, phase overviews, full detail files, or `docs/AGENTS.md` unless the missing fact requires it.

## Write / Verify

- Update only the affected task, plan README state block/table row, `SNAPSHOTS.md`, and compact `HANDOFF.md` if it already exists.
- Routine verification: narrow helper if present; otherwise affected Markdown links and `git diff --check`.
- Full structural checks only for init, migration, or contract edits.
- Avoid large stable-prefix rewrites unless they make future routine reads smaller.

## References

- Read [references/init-and-migration.md](references/init-and-migration.md) only for `fastpath init`, contract installation, or migration.
- Read [references/plan-contract.md](references/plan-contract.md) only for creating, splitting, restructuring, Fast Path schema changes, or structural checks.
- Read [references/language-policy.md](references/language-policy.md) only for document creation, label/name changes, or language choice.
- Do not load references during routine progress unless required.
