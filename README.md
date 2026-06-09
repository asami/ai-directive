# AI Directive

This repository defines the **authoritative AI directive** used across projects.

It provides a structured contract that governs how different AI runtimes
(interactive and execution-oriented) must behave when working with a project.

This repository is typically mounted into a project as a Git submodule at:

    ai/directive

and treated as an external, versioned contract.

## Project Setup

Use the setup guide when adopting this directive in a project:

    ai/directive/samples/setup.md

Minimal setup:

```sh
git submodule add https://github.com/asami/ai-directive.git ai/directive
ln -s ai/directive/core/AGENT.md .
ln -s ai/directive/core/RULE.md .
```

The `ai/directive` directory holds the shared directive. The project root
`AGENT.md` and `RULE.md` should be symbolic links to the authoritative core
documents so AI runtimes can find the rules from the project root.

For project README and docs-layer README templates, follow
`samples/setup.md`.

## Structure

```
ai-directive/
├─ core/               # Mandatory core rules (apply to all AI runtimes)
├─ chatgpt-desktop/    # Profile for interactive ChatGPT Desktop usage
├─ codex/              # Profile for Codex execution-only usage
└─ samples/            # Non-authoritative examples and templates
```

### core/

The **core** directory defines rules that apply to **all AI runtimes**.

- Authority and priority model
- Fundamental MUST / MUST NOT constraints
- Output and execution discipline
- Scope and interpretation boundaries

All other profiles build on top of these rules.
Core rules are always applied first.

### chatgpt-desktop/

The **chatgpt-desktop** profile defines behavior for an
**interactive, conversational AI**.

- Design, analysis, and documentation support
- Human-in-the-loop collaboration
- No direct execution or file modification
- Clarification and option presentation are allowed and encouraged

This profile is intended for use with ChatGPT Desktop–style workflows.

### codex/

The **codex** profile defines behavior for an
**non-interactive execution AI**.

- Instruction-driven operation
- File modification and command execution
- One instruction per run
- No inference beyond explicit directives
- Stop on ambiguity or unsafe conditions

This profile is intended for Codex-style execution workflows only.

### samples/

The **samples** directory contains **NON-AUTHORITATIVE** material.

- Example files
- Templates
- Reference directory layouts

Files under `samples/` are provided **for human reference only**.

AI MUST NOT:
- Treat samples as active rules
- Enforce or infer behavior from samples
- Use samples as overrides or extensions

## Priority Model

When applied within a project, rules are interpreted in the following order:

1. core/
2. Selected profile (chatgpt-desktop or codex)
3. Project-specific rules (outside this repository)

Project rules may add constraints but MUST NOT contradict this directive
unless an explicit exception is documented.

## Versioning

This repository is expected to be:
- Versioned via Git tags
- Updated explicitly by consuming projects
- Referenced in project journals when updated

## Summary

This repository is not documentation.
It is a **contract**.

Projects adopt it.
AI runtimes obey it.
