# Init and Migration

Read this reference only for `fastpath init`, contract installation, or migration of existing plan documents.

## Init Workflow

1. Read `references/plan-contract.md` and `references/language-policy.md` because init establishes long-lived rules.
2. Ensure `docs/AGENTS.md` exists and contains the contract.
3. If `docs/plans/AGENTS.md` exists, align it with `docs/AGENTS.md` or make it defer to `../AGENTS.md`; do not make it the only rule source.
4. Ensure `docs/plans/README.md` exists when `docs/plans` exists or a plan is being created.
5. Inspect root entries and plan README files first. Do not load every detail file.
6. If the structure is compliant, report that briefly and do not rewrite it.
7. If it is noncompliant, summarize the structure and ask before moving, splitting, or renaming existing documents.
8. Reorganize existing documents only after approval. Create new documents in the contract structure immediately.

## Migration Rules

- Preserve existing language and labels unless the user requests a change.
- Preserve local history and working-tree changes.
- Use the section fast path while oversized documents await restructuring approval.
- Update `docs/plans/README.md` when a plan is added, completed, renamed, or deleted.
- After migration, validate all local plan links, required folders, completed-file placement, the `docs/AGENTS.md` contract, and `git diff --check`.
