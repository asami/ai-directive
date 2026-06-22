SmartDox Authoring Rules
========================

status=published
published_at=2026-06-23

# PURPOSE

This document defines mandatory SmartDox authoring rules for agents editing
public-facing `.dox` documents or generating `.dox` scaffold files.

These rules exist because SmartDox Dox is not Markdown. Markdown-like heading
habits can create syntactically ambiguous or invalid SmartDox metadata.

# HEAD METADATA SECTIONS

SmartDox metadata subsections such as `HEADLINE`, `BRIEF`, `SUMMARY`, and
`DESCRIPTION` MUST have a blank line between the subsection heading and its
body.

Correct:

```dox
## HEADLINE

KnowledgeHub
```

Incorrect:

```dox
## HEADLINE
KnowledgeHub
```

Correct:

```dox
## BRIEF

KnowledgeHub のカテゴリ、用語、RDFから知識を探索するための短い導入。
```

Incorrect:

```dox
## BRIEF
KnowledgeHub のカテゴリ、用語、RDFから知識を探索するための短い導入。
```

# AGENT REQUIREMENTS

When editing or generating `.dox` files, agents MUST:

- Treat SmartDox Dox as its own syntax, not as Markdown.
- Preserve the blank line after metadata subsection headings.
- Use existing SmartDox/Dox parser and metadata APIs when reading metadata.
- Use generator helpers for scaffolded Dox metadata sections when available.
- Add or update Executable Specifications when generator output depends on Dox
  metadata parsing.

Agents MUST NOT:

- Collapse `## HEADLINE` and the headline text into adjacent lines.
- Collapse `## BRIEF` and the brief text into adjacent lines.
- Add compatibility fallback parsers to hide invalid Dox produced by generators.
- Treat rendered HTML as the source of truth when a Dox object or SmartDox
  metadata API is available.

# REVIEW REQUIREMENTS

Reviewers MUST check modified `.dox` files and generated `.dox` fixtures for
metadata subsection spacing. A diff that introduces adjacent metadata heading and
body lines is a review finding.

For generated Dox, reviewers SHOULD also check that the generator has an
Executable Specification asserting the correct blank-line form.
