# Comparison and Selection document structure template

Date: 2026-11-17

## Request and scope

Add 比較・選択型 (Comparison and Selection, `comparison-and-selection`) as the fourth shared technical-document structure template. Work A is the documentation change: define its outline, each part’s role, and selection criteria using the existing development-method comparison as source material. Work B is checking the catalog, entry points, and compatibility with the shared writing rules.

The source is `textus-technical-documentation`, `src/main/smartdox/development-guide/development-methods/order-management-development-methods.dox/`: its Core, localized Documents, and SmartDox article compare conventional development, UI-driven AI, specification-driven AI, and SimpleModeling with AI. The Japanese article supplies the two-warehouse case, common acceptance conditions, and questions about reading specifications, making changes, reuse, verification, and inheritance of decisions. Its multi-year case motivates comparison over a lifecycle. These are materials for a reusable structure, not measured evidence that one development method is superior.

## Structure and selection

The outline is lead; decision context and purpose; common comparison basis; how each alternative works; worked comparison; findings and tradeoffs; selection conditions; summary. The lead supplies the conditional finding early; the later synthesis and selection explain its grounds. The common basis fixes the outcome and acceptance conditions. Criteria come from the decision purpose. The case connects each approach’s mechanism to observable work and results, and the synthesis explains benefits, burdens, limitations, and unknowns.

Choose the template when alternatives and conditional selection organize the whole document. Definition First remains appropriate for defining one subject and explaining its responses to problems. Concept to Realization remains appropriate for connecting one system’s concepts, design, and runtime behavior. The existing `comparison` section pattern supports local comparisons; the new document-template ID is distinct.

The rules distinguish shared requirements from preferences, disclose priorities when they affect a recommendation, and distinguish documented capabilities, design reasoning, illustrative examples, and measured results. Selection remains conditional on the stated setting and evidence. Existing template meanings, the Background First default, and DSL fields remain unchanged.

## Delivery boundary

Edit the standalone `ai-directive` repository first. The consuming repository can adopt a committed revision through its `ai/directive` submodule. The source comparison article is used as material and is not restructured by this change. No media generation or remote publication is required.
