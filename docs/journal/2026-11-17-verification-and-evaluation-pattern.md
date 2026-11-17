# Verification and Evaluation section explanation pattern

Date: 2026-11-17

## Request and scope

Add 検証・評価型 (Verification and Evaluation, `verification-and-evaluation`) as the ninth shared section explanation pattern, with explicit selection criteria distinguishing it from Procedure and Worked Example. Work A is the shared documentation change; Work B is checking catalog identities, entry points, references, and the separation from logical relations and DSL fields.

## Pattern and selection

The reader’s central question is what the evidence establishes about a claim and within which limits. The opening establishes the question and gives the current scoped judgment, including an inconclusive judgment where appropriate. The supporting explanation relates the claim and evaluation criteria, evaluated subject and conditions, evidence and results, interpretation, and bounded judgment with its remaining unknowns.

Procedure explains how readers carry out a check and verify its outcome. Worked Example traces a particular case to explain general behavior, whether the case is hypothetical or observed. Verification and Evaluation interprets evidence against criteria to establish what can be concluded. Separate subsections can carry the method and an illustrative case while the evaluation owns the criteria and final judgment. Comparison remains appropriate when the central question is the difference among alternatives and the conditions for selecting them.

The order-update example uses the same subject across all three patterns: how to check a stale expected revision; how a stale update follows a rejection path; and whether available test results establish rejection without changing the stored order under the tested conditions. These are explanatory examples, not a report of an executed test.

The pattern distinguishes required behavior, implementation inspection, derivation, and executed results. It does not turn plans or hypothetical cases into execution evidence or generalize one successful case beyond its scope. It adds an authoring selection; existing pattern IDs and the Core and Document DSLs are preserved.

## Delivery boundary

The changes belong in the standalone `ai-directive` repository: `core/technical-writing-patterns.md`, the section-pattern entry point in `core/technical-writing.md`, `README.md`, and this journal. A coexisting change to `core/technical-writing-templates.md` is outside this request and remains preserved. The consuming `textus-technical-documentation` repository adopts the committed revision through its submodule. Existing guide manuscripts are not rewritten by this request.
