# Manual Instruction: Scala `@version` Update

Use this instruction when you want to run the header version update manually.

```text
Update @version timestamps in Scala source files.

Goal:
Maintain version history in header comments while updating the latest "@version" entry.

Scope:
- Scala files (*.scala) edited in the current task
- When preparing a commit, re-check all Scala files included in the commit

File selection:

1. During file editing:
   - Apply this update to every Scala file whose source content is changed.
   - Do this as part of the file edit, not only at commit time.

2. Before committing:
   - Use git to identify Scala files included in the commit.
   - Re-check the header version block for each target file.

3. From the result:
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
- Parse the complete header comment block, not a fixed number of lines.
- The header comment block is the first `/* ... */` comment near the top of the file.
- Read from `/*` through the matching `*/`, even when long imports or package declarations make the first N lines insufficient.
- Look for "@since", "version", and "@version" lines only inside that header comment block.
- Do not insert or move version lines outside the header comment block.

2. Update (Latest Version)
- Replace the latest "@version" line with today's date

3. History Preservation (IMPORTANT)
- Keep exactly ONE "@version" line: the latest date.
- Preserve existing history entries (`*  version ...`) in their original relative order unless an explicit cleanup rule below applies.
- Existing history entries are not the same thing as old `@version` lines:
  - Existing `*  version ...` entries are historical facts. Keep them.
  - Old `* @version ...` entries are converted or removed according to the rules below.
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
- Build the result from the original header's version block, preserving the original order of existing history lines.
- Do not append old history lines after the final `@version`.
- The final version block must have this order:
  1. `@since`, if present
  2. existing history lines that are preserved, in their original relative order
  3. converted older `@version` entries that must be preserved, placed where their original `@version` appeared relative to the other version lines
  4. exactly one latest `@version`
  5. non-version metadata such as `@author`
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
  - If a line converted from an old `@version` would be in the same month/year as the latest "@version",
    remove that converted line.
  - Do not remove an already-existing `*  version ...` history line merely because it is in the same month/year as the latest "@version".
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
- Do NOT remove existing history entries, except when the history line has the same date as `@since`
- Do NOT replace an existing `*  version ...` history line with the new `@version`
- Do NOT delete an existing history line when updating `@version`, unless an explicit cleanup rule above applies
- Do NOT create this broken shape:
    *  version <old>
    * @version <newer>
    *  version <older>
    * @version <latest>
  There must be no `*  version ...` line after the final `* @version ...`.
- If this broken shape already exists, repair it by collecting the existing history lines in their original relative order, applying the cleanup rules, and emitting one contiguous block before the single latest `@version`.

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

Bad:
    /*
     * @since   Aug.  1, 2025
     *  version Mar. 29, 2026
     * @version Apr.  7, 2026
     *  version Aug.  2, 2025
     *  version Apr.  7, 2026
     * @version Apr. 13, 2026
     * @author  ASAMI, Tomoharu
     */

Reason:
    - The header was not treated as one complete version block
    - Existing history was moved after an `@version`
    - There are multiple `@version` lines
    - A same-month old `@version Apr.  7, 2026` was kept as history even though the latest is `Apr. 13, 2026`

Good:
    /*
     * @since   Aug.  1, 2025
     *  version Aug.  2, 2025
     *  version Mar. 29, 2026
     * @version Apr. 13, 2026
     * @author  ASAMI, Tomoharu
     */

7. Date
- Use the current system date
- Format must match:
    %b. %e, %Y

8. Git Integration
- During implementation:
  - Update the header when editing a Scala file.
- Before committing:
  - Re-check every Scala file included in the commit.
  - Fix any version header drift before creating the commit.

9. Deliverable
- Apply changes directly to files
- Do not output explanations
```
