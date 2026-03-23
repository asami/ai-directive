# Manual Instruction: Scala `@version` Update

Use this instruction when you want to run the header version update manually.

```text
Update @version timestamps in Scala source files.

Goal:
Maintain version history in header comments while updating the latest "@version" entry.

Scope:
- Only Scala files (*.scala) that are staged for commit (pre-commit target)

File selection:

1. Use git to identify target files:

    git diff --cached --name-only

2. From the result:
   - Select only files ending with ".scala"
   - Ignore deleted files

---

Target format:
    * @version %b. %e, %Y

History format:
    *  version %b. %e, %Y

Example:
    * @version Mar. 24, 2026

---

Rules:

1. Detection
- Look for "@version" lines in the header comment (top of file)

2. Update (Latest Version)
- Replace the latest "@version" line with today's date

3. History Preservation (IMPORTANT)
- If an existing "@version" line is replaced:
  - Convert the previous "@version" line into a history entry:
        *  version <old-date>
  - Remove the "@" prefix but keep the date

Example:

Before:
    * @version Mar. 13, 2026

After:
    *  version Mar. 13, 2026
    * @version Mar. 24, 2026

4. Deduplication
- Ensure:
  - Only ONE "@version" line exists
  - Multiple history lines ("version") are allowed
- If multiple "@version" lines exist:
  - Keep only the latest as "@version"
  - Convert others into history entries

5. Insert
- If "@version" does NOT exist:
  - If "@since" exists:
    - Insert "@version" immediately after "@since"
  - Otherwise:
    - Insert at the top comment block

6. Constraints
- Do NOT modify any code outside comments
- Preserve indentation and comment style (e.g., leading " * ")
- `@version` line MUST be formatted as `* @version ...` (single space after `*`)
- Do NOT reorder history lines
- Do NOT remove existing history entries

7. Date
- Use the current system date
- Format must match:
    %b. %e, %Y

8. Git Integration
- After modifying files:
  - Re-stage the updated files

9. Deliverable
- Apply changes directly to files
- Do not output explanations
```

