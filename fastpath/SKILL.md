---
name: fastpath
description: Minimize plan-reading cost with low-context task fast paths, behavior rules, and indexes
---

# Fast Path

## Goal

Reduce actual model cost: trust valid task pointers, read the minimum slice, avoid rediscovery, write compactly.

## Routine

1. Read `SNAPSHOTS.md` once.
2. If `mode: routine` has `plan_readme`, `detail_file`, current task id/heading, next task, and preferably `line_start`/`line_end`, trust it. No search, neighbors, or history.
3. Read the plan state once only when required by project instructions or state update. Read the detail line range; without a range, read only the exact heading section.
4. Update only touched task/state/snapshot/HANDOFF fields, preserving compact line ranges.
5. Run narrow verification only. Do not reread docs for summary.
6. Final: one line with task, result, verification id, exact/protocol if known.

## Discovery

Only when Fast Path is missing/conflicting: exact link first; id/title gets one bounded `rg -n`; unknown task reads root plan index, selected state block, and one required detail. Do not read unrelated plans, full histories, phase overviews, full detail files, or `docs/AGENTS.md` unless needed.

## Write / Verify

- Keep snapshots/project instructions free of benchmark formulas, prices, or long policy text.
- Prefer narrow helper; otherwise affected links and `git diff --check`.
- Full structural checks/reference loads only for init, migration, restructuring, schema changes, or explicit missing facts.

## References

- Init/migration: [init-and-migration.md](references/init-and-migration.md)
- Contract/schema: [plan-contract.md](references/plan-contract.md)
- Language/naming: [language-policy.md](references/language-policy.md)
