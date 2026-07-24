---
name: fastpath
description: Minimize plan-reading cost with low-context task fast paths, behavior rules, and indexes
---

# Fast Path

## Goal

Reduce actual model cost: trust valid task pointers, use the compact helper, avoid rediscovery, write compactly. In structured-doc benchmarks, S1 (structured + skill) should have the lowest Cost-equivalent of L0/L1/S0/S1.

## Routine

1. Structured routine first read: if `read_command` is visible, run it once exactly, adding `-Compact` only when missing. Else run `.\tools\fastpath-read.ps1 <read_args> -Compact` when that wrapper exists; else run `$env:CODEX_HOME\skills\fastpath\scripts\read-fastpath.ps1 <read_args> -Compact`. Hand-build reads only if the helper is unavailable or fails.
2. Routine turns must not tool-read `SKILL.md`; this contract is already active. If `mode: routine` has `plan_readme`, `detail_file`, current task id/heading, next task, and preferably `line_start`/`line_end`, `read_command`, or `read_args`, trust it. No search, neighbors, history, or broad plan scan.
3. Read the plan state once only when required by project instructions or state update. Read the detail line range; without a range, read only the exact heading section.
4. Update only touched task/state/snapshot/HANDOFF fields, preserving compact line ranges and next routine pointers.
5. Run narrow verification only. Do not reread docs for summary.
6. Treat S0 as the cost floor to beat: do not spend extra reads, reasoning, or output just to apply the skill when the structured path is already clear.
7. Avoid todo lists, interim status explanations, and repeated summaries during routine work or benchmarks unless the user asks. Final: one compact line with task, result, verification id, exact/protocol if known.

## Discovery

Only when Fast Path is missing/conflicting: exact link first; id/title gets one bounded `rg -n`; unknown task reads root plan index, selected state block, and one required detail. Do not read unrelated plans, full histories, phase overviews, full detail files, or `docs/AGENTS.md` unless needed.

## Write / Verify

- Keep snapshots/project instructions free of benchmark formulas, prices, or long policy text.
- Use compact helper; otherwise affected links and `git diff --check`.
- Full structural checks/reference loads only for init, migration, restructuring, schema changes, or explicit missing facts.

## References

- Init/migration: [init-and-migration.md](references/init-and-migration.md)
- Contract/schema: [plan-contract.md](references/plan-contract.md)
- Language/naming: [language-policy.md](references/language-policy.md)
