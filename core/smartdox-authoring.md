SmartDox Authoring Rules
========================

status=published
published_at=2026-06-23

# PURPOSE

This document defines mandatory SmartDox authoring rules for agents editing
public-facing `.dox` documents or generating `.dox` scaffold files.

These rules exist because SmartDox Dox is not Markdown. Markdown-like heading
habits can create syntactically ambiguous or invalid SmartDox documents.

# SECTION TITLE TERMINATION

A SmartDox section title is terminated by a blank line. This is intentional:
SmartDox allows multi-line section titles, so a non-blank line immediately after
a section heading can be interpreted as a continuation of the section title, not
as body content.

For one-line section titles, agents MUST put one blank line immediately after the
heading line before writing body content or child sections.

Correct one-line section title:

```dox
# Overview

This is body text.
```

Correct multi-line section title:

```dox
# Long section title
continued title line

This is body text.
```

Incorrect when `This is body text.` is intended as body content:

```dox
# Overview
This is body text.
```

# HEAD METADATA SECTIONS

Reserved metadata sections and subsections such as `HEAD`, `HEADLINE`, `BRIEF`,
`SUMMARY`, and `DESCRIPTION` use the section body for metadata content. Their
section names are not multi-line titles. They MUST have a blank line between the
metadata heading and its body.

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
- Preserve the blank line after one-line section headings.
- Preserve the blank line after reserved metadata section headings.
- Use existing SmartDox/Dox parser and metadata APIs when reading metadata.
- Use generator helpers for scaffolded Dox metadata sections when available.
- Add or update Executable Specifications when generator output depends on Dox
  metadata parsing.

Agents MUST NOT:

- Collapse a one-line section heading and its body into adjacent lines.
- Collapse `## HEADLINE` and the headline text into adjacent lines.
- Collapse `## BRIEF` and the brief text into adjacent lines.
- Add compatibility fallback parsers to hide invalid Dox produced by generators.
- Treat rendered HTML as the source of truth when a Dox object or SmartDox
  metadata API is available.

# REVIEW REQUIREMENTS

Reviewers MUST check modified `.dox` files and generated `.dox` fixtures for
section title termination. A diff that introduces adjacent section heading and
body lines is a review finding unless the following non-blank lines are clearly
intended as a multi-line section title and are terminated by a later blank line.

Reserved metadata headings are strict: adjacent metadata heading and body lines
are always a review finding.

For generated Dox, reviewers SHOULD also check that the generator has an
Executable Specification asserting the correct blank-line form.
