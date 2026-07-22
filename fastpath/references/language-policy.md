# Language Policy

Read this reference only when creating plan documents, changing labels or names, or resolving a language preference.

## Defaults

- Follow the user's requested body language. If none is specified, follow existing project documents.
- Use simple English index headers and progress labels by default: `Title`, `Progress`, `Summary`, `no checklist`, `done`, `partial`, and `pending`.
- Use readable English kebab-case plan folders and detail filenames by default.

## Overrides

- Follow explicit user requests for body language, table headers, progress wording, or filename style.
- Preserve the three index meanings even with custom labels: linked title, progress, and short summary.
- Do not rewrite existing language or labels only for normalization.
- During init, write the selected long-lived preference into `docs/AGENTS.md`.
