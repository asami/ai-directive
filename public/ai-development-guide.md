# AI Directive Public Development Guide

Projection identity: `DOC03-AI-DIRECTIVE-PROJECTION`

This document is a concise public guidance projection for the shared AI
Directive. `README.md` is the public guide surface and repository orientation;
this page provides its focused development projection.

## Authority boundaries

- Authoritative behavior comes from `core/` together with the selected runtime
  profile (`chatgpt-desktop/` or `codex/`).
- This projection is descriptive only. It never grants authority, overrides
  authority, activates or executes anything, or changes the shared Directive.
- Material under `samples/` is illustrative and is not a rule or authority
  source.
- Repository-local extensions remain outside shared `core/` and selected-profile
  authority. They may provide local context within the documented priority
  boundary, but they do not replace or silently contradict the shared
  Directive.

The shared Directive remains the contract consumed by adopting projects. Use
the repository README and the authoritative core/profile documents when
resolving behavior or priority.
