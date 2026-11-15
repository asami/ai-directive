# Top-down Technical Writing

Date: 2026-11-15

The user adopted the policy: technical documents use a top-down hierarchy,
and each section proceeds from its key point to supporting detail.

Added this policy to `core/technical-writing.md`: state the most important
information, conclusion or overview first, then decompose it into major
points and supporting evidence, conditions, mechanisms and examples. Apply
the same order recursively within chapters, sections, items and paragraphs.
Readers should understand the overview at the upper levels and choose which
details to follow. Do not defer essential information to a late narrative
reveal.

Clarified that both existing structure templates state their key points in
the lead. Background First retains its background/necessity chapters after
that lead. Template identities and selection defaults are preserved.

Preserved the existing uncommitted template and writing-rule changes. Added
the user's policy to the local authoring guide in
`textus-technical-documentation` so it applies there immediately. Consuming
submodule working trees and gitlinks were not changed. No historical journal,
guide manuscript or generated PDF was edited. No commit, push or broad
directive distribution was requested.

## Recursive explanation structure after article review

The user refined the section policy after reviewing the observed-model
article: begin with the relevant background, problem or purpose, state the
claim, then break down that claim. Apply this structure recursively to the
whole document, chapters, sections, subsections, items and paragraphs.

Updated `core/technical-writing.md` to make that sequence explicit. Each
opening supplies only the context needed to understand its claim; shared
context need not be repeated. Supporting material must explain the claim,
and each child unit follows the same structure. Core authoring establishes
these relationships before prose. Review follows headings and openings,
then checks each supporting explanation against its parent claim. Adding a
claim sentence to an otherwise unstructured section is insufficient.

This refinement replaces the earlier literal requirement to place the key
point in the first sentence of every unit. The claim remains near the
beginning, after concise context where needed. Template identities and
chapter sequences are unchanged. Only the standalone shared rule and this
journal were edited; consumer submodule pointers await a committed shared
revision. No commit, push or submodule distribution was requested.

## Named section patterns and logic-tree-to-prose correspondence

The user requested named section/subsection patterns to be visible in logic
trees and used to organize the corresponding prose. Added the shared
`core/technical-writing-patterns.md` catalog with eight Japanese/English
patterns and stable IDs. It defines the question, opening context, central
answer and supporting breakdown for each unit, recursive selection, review
display and prose correspondence. The shared writing rule links to this
catalog; document-level template identities are unchanged.

The explanation patterns are distinct from existing structural DSL values
such as `mapping` and `causal-chain`. Existing observed-model sources were
inspected only to confirm that distinction. No undefined DSL fields were
added, no renderer support was claimed, and no article or generated HTML
was changed in this rule-definition task. Unsupported annotations are to be
kept in separate authoring data linked to existing section IDs until a
supported representation and corresponding confirmation display are used.

Only the standalone shared catalog, rule and journal were edited. Consumer
submodule updates require a committed directive revision; no commit, push
or distribution was requested.
