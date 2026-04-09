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
- Keep exactly ONE "@version" line: the latest date.
- For older "@version" lines:
  - If the older date is in a different month/year from the latest "@version",
    convert it into a history entry:
        *  version <old-date>
  - If the older date is in the same month/year as the latest "@version",
    remove it (do not keep it as history).

Example A (different month):

Before:
    * @version Feb. 19, 2026
    * @version Apr.  9, 2026

After:
    *  version Feb. 19, 2026
    * @version Apr.  9, 2026

Example B (same month):

Before:
    * @version Apr.  3, 2026
    * @version Apr.  9, 2026

After:
    * @version Apr.  9, 2026

4. Deduplication
- Ensure:
  - Only ONE "@version" line exists
  - Multiple history lines ("version") are allowed
- If multiple "@version" lines exist:
  - Keep only the latest as "@version"
  - Convert others into history entries
- @since overlap cleanup:
  - If a history line has the same date as "@since", remove that history line.
  - Example:
    Before:
        * @since   Mar. 20, 2026
        *  version Mar. 20, 2026
        * @version Mar. 25, 2026
    After:
        * @since   Mar. 20, 2026
        * @version Mar. 25, 2026
- Month compression:
  - If history contains entries in the same month/year as the latest "@version",
    remove those same-month history entries.
  - Exception:
    - If the previous "@version" date is in the same month/year as "@since" but the day differs,
      preserve that previous "@version" as a history entry.
    - Example:
      Before:
          * @since   Mar. 21, 2026
          * @version Mar. 23, 2026
      After:
          * @since   Mar. 21, 2026
          *  version Mar. 23, 2026
          * @version Apr.  2, 2026

Example:

Before:
    * @since   Jan.  6, 2026
    *  version Jan. 21, 2026
    *  version Feb. 25, 2026
    *  version Mar. 20, 2026
    * @version Mar. 24, 2026

After:
    * @since   Jan.  6, 2026
    *  version Jan. 21, 2026
    *  version Feb. 25, 2026
    * @version Mar. 24, 2026

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
- Do NOT remove existing history entries, except by the month-compression rule above
- Do NOT replace an existing `*  version ...` history line with the new `@version`
- Do NOT delete an existing history line when updating `@version`, unless an explicit cleanup rule above applies

Failure examples:

Bad:
    /*
     * @since   Jan.  7, 2026
     *  version Jan. 20, 2026
     * @version Apr.  9, 2026
     * @author  ASAMI, Tomoharu
     */

Reason:
    - The previous `@version Feb. 19, 2026` was not preserved as `*  version Feb. 19, 2026`

Good:
    /*
     * @since   Jan.  7, 2026
     *  version Jan. 20, 2026
     *  version Feb. 19, 2026
     * @version Apr.  9, 2026
     * @author  ASAMI, Tomoharu
     */

Bad:
    /*
     * @since   Jan.  1, 2026
     *  version Apr.  6, 2026
     * @version Apr.  9, 2026
     *  version Mar. 30, 2026
     *  version Jan. 22, 2026
     *  version Feb. 17, 2026
     * @author  ASAMI, Tomoharu
     */

Reason:
    - Existing history lines were reordered
    - `@version` must be the newest line, but older `version` lines must keep their original order

Good:
    /*
     * @since   Jan.  1, 2026
     *  version Jan. 22, 2026
     *  version Feb. 17, 2026
     *  version Mar. 30, 2026
     * @version Apr.  9, 2026
     * @author  ASAMI, Tomoharu
     */

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
