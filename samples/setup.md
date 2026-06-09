# AI Directive Project Setup

This guide shows how to adopt `ai-directive` in a project.

The required pieces are:

- `ai/directive` as the shared directive repository.
- `AGENT.md` as a symbolic link to `ai/directive/core/AGENT.md`.
- `RULE.md` as a symbolic link to `ai/directive/core/RULE.md`.

The README and docs-layer README files are optional templates for projects that
want the standard documentation structure.

## Required Setup

```
$ git submodule add https://github.com/asami/ai-directive.git ai/directive
```

```
$ ln -s ai/directive/core/AGENT.md .
```

```
$ ln -s ai/directive/core/RULE.md .
```

## Optional Project README

```
$ cp ai/directive/samples/README.md.sample ./README.md
```

## Optional Docs Layer READMEs

```
$ mkdir -p docs/phase docs/journal docs/notes docs/design docs/spec
```

```
$ cp ai/directive/samples/docs-phase-README.md.sample docs/phase/README.md
```

```
$ cp ai/directive/samples/docs-journal-README.md.sample docs/journal/README.md
```

```
$ cp ai/directive/samples/docs-notes-README.md.sample docs/notes/README.md
```

```
$ cp ai/directive/samples/docs-design-README.md.sample docs/design/README.md
```

```
$ cp ai/directive/samples/docs-spec-README.md.sample docs/spec/README.md
```
