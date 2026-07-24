---
name: fastpath
description: Minimize plan-reading cost with low-context task fast paths, behavior rules, and indexes
---

# Fast Path

## Goal

Minimize actual cost. Trust valid pointers, run one compact helper read, avoid rediscovery, write one-line finals. In structured-doc benchmarks, S1 must be the lowest Cost-equivalent cell.

## Routine

1. Structured routine read: run `powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\fastpath-read.ps1 -SnapshotPath .\SNAPSHOTS.md -Compact` once. Helper output is the snapshot/plan/detail proof. Do not parse `read_command` or reread `SKILL.md`; use explicit args only if auto helper fails.
2. If `mode: routine` gives `plan_readme`, task id/heading, next task, and line range/detail, trust it. No search, neighbors, history, or broad plan scan.
3. Update only touched task/state/snapshot/HANDOFF fields. Preserve compact line ranges and next pointers.
4. Verify narrowly. Do not reread docs for summary.
5. Beat S0: no second snapshot read, no explanation/todo chatter, final one compact line with task/result/verification/exact-protocol if known.

## Discovery

Only when Fast Path is missing/conflicting: exact link first; id/title gets one bounded `rg -n`; unknown task reads root plan index, selected state block, and one required detail. Avoid unrelated plans, histories, phase overviews, full detail files, and `docs/AGENTS.md`.

## Write / Verify

- Keep snapshots free of benchmark formulas/prices.
- Use compact helper; otherwise affected links and `git diff --check`.
- Load references only for init, migration, restructuring, schema changes, or missing facts.

## References

- Init/migration: [init-and-migration.md](references/init-and-migration.md)
- Contract/schema: [plan-contract.md](references/plan-contract.md)
- Language/naming: [language-policy.md](references/language-policy.md)
