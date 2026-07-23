---
name: fastpath
description: Minimize plan-reading cost with task fast paths, cost-aware budgets, and indexes
---

# Fast Path For Plan Docs

## Goal

Reduce actual model cost while preserving plan correctness. Treat token reduction as the means, not the end.

- Raw total shows how much context moved.
- Uncached total shows the new processing burden.
- Cost-equivalent, including `cache_write_tokens` when measured, is the final cost signal.

## Routine

For ordinary progress on a known planned task:

1. Read `SNAPSHOTS.md`.
2. If `## Fast Path` has `mode: routine`, `plan_readme`, `detail_file`, `task_id` or `heading`/`anchor`, next task info, and preferably `line_start`/`line_end`, trust it. Do not rediscover.
3. Read only the plan README top state block and the detail line range. If no range exists, read only the current heading section.
4. Apply the update, then do not reread docs just to summarize.
5. Final reply: task/result, verification id, exact/protocol if known. No document recap or success log; keep output inside the budget.

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
- Prefer changes that reduce Cost-equivalent. Avoid large stable-prefix rewrites that create cache writes unless later cache reuse justifies them.

## References

- Read [references/init-and-migration.md](references/init-and-migration.md) only for `fastpath init`, contract installation, or migration.
- Read [references/plan-contract.md](references/plan-contract.md) only for creating, splitting, restructuring, Fast Path schema changes, or structural checks.
- Read [references/language-policy.md](references/language-policy.md) only for document creation, label/name changes, or language choice.
- Do not load references during routine progress unless required.
