# Plan Contract

Read this reference only when creating, splitting, restructuring, or checking structural compliance.

## Required Layout

```text
docs/plans/
  README.md
  <plan-name>/
    README.md
    active/
    completed/
```

- Keep the `docs/plans` root limited to `README.md`, optional `AGENTS.md`, and plan folders.
- Use readable English kebab-case names unless the user requests another style.
- Put unfinished, partial, pending, or no-checklist details in the plan-local `active/` folder.
- Put actually completed details in the same plan's `completed/` folder.

## Plan README

Keep the authoritative state block within the first 20 lines:

```markdown
## State

Progress: 35 / 42
Current task: [title](active/task.md)
Next task: [title](active/next-task.md)
```

Then include a linked table:

```markdown
| Title | Progress | Summary |
| --- | --- | --- |
```

- Use `Current task: none` or `Next task: pending selection` when no link is known; do not invent work.
- Link every table title to a local detail `.md` file under `active/` or `completed/`.
- Use `[O]`/`[x]` = 1, `[~]` = 0.5, `[ ]` = 0, and `no checklist` when no checks exist, unless the user requests other labels.

## SNAPSHOTS Fast Path

For routine work, include this block in root `SNAPSHOTS.md`:

```markdown
## Fast Path

- mode: routine
- plan_readme: `docs/plans/<plan>/README.md`
- state_block: top 20 lines
- detail_file: `docs/plans/<plan>/active/<file>.md`
- task_id: `P1-32`
- heading: `P1-32. Title`
- anchor: `#p1-32-title`
- line_start: 123
- line_end: 145
- next_task: `P1-33. Title`
- next_detail_file: `docs/plans/<plan>/active/<file>.md`
- final_response_budget: task, result, verification id, exact/protocol only
```

- Use `mode: discovery` when the current task is unknown; keep known `plan_readme` and next task fields.
- Prefer `task_id` and `line_start`/`line_end` over fuzzy heading search.
- Update line ranges whenever the affected task section moves.
- Keep `next_task` unique enough that the next routine turn does not need title discovery.

## Detail Size Budget

- Keep a detail file at or below 400 lines and 10 task headings when practical.
- Split new oversized content before finishing.
- Prefer a cluster of 5-10 related tasks over one file per trivial checkbox.
- Keep the current task directly linked from the plan README.
- Keep task headings unique with a stable id when possible.
- Move completed task clusters to `completed/`; keep remaining cross-cutting verification in a focused active detail.
- For an existing oversized file, summarize the proposed split and ask before restructuring unless the user already authorized it.
- Until approval, locate the exact heading and read only that section.

## Granularity Choice

When a plan nests as stage > substage > task and splitting will create many files, offer:

1. **phase-level**: one file per top-level stage.
2. **step-level (Recommended)**: one file per major substage or related task cluster.
3. **task-level**: one file per detailed task/checklist cluster.
4. **custom-level**: the user's stated boundary.

If the user does not choose, use step-level for a large plan and phase-level for a small plan. Ask one concise question only when a custom boundary is unclear.

## docs/AGENTS.md Contract

Record these durable rules in `docs/AGENTS.md`:

- Use index-first discovery and the known-task section fast path.
- Keep the `SNAPSHOTS.md` Fast Path schema with `task_id`, line range, and compact final response budget.
- Apply the language policy and user overrides.
- Require plan-local `README.md`, `active/`, and `completed/`.
- Require `Current task`/`Next task` state and linked title/progress/summary rows.
- Use the 400-line/10-task-heading size guard and obtain approval before restructuring existing content.
- Keep completed details under their plan's `completed/` folder.
- Update the top-level plan index when plan lifecycle state changes.
