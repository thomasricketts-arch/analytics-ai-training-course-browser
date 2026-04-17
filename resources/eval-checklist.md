# Eval Checklist: Verifying Claude Code Output

**Use this whenever Claude Code produces SQL, data analysis, or analytical content.**

The difference between useful AI and dangerous AI is whether you verify the output before trusting it.

---

## For SQL and Queries

- [ ] **Does it run?** Copy into Snowflake and execute. Syntax errors are immediate.
- [ ] **Are the table and column names real?** Claude can hallucinate table/column names that don't exist. Spot-check against your actual schema.
- [ ] **Are the JOINs correct?** Check the join keys and join type (LEFT, INNER, etc.). Wrong joins are a common source of inflated or missing rows.
- [ ] **Does the row count make sense?** Run a COUNT(*) first. If you expect ~10K rows and get 800K, something is wrong.
- [ ] **Are NULLs handled?** Check whether the query accounts for NULLs in key columns (especially in WHERE clauses and aggregations).
- [ ] **Are date filters correct?** Date logic is frequently wrong. Verify the date range returns what you intended.
- [ ] **Do the numbers match a known benchmark?** If you have a SOT or a prior report to compare against, check a few key metrics.
- [ ] **Would you put this in a report without changes?** If not, what would you change?

---

## For Data Analysis and Summaries

- [ ] **Is the math right?** Spot-check at least one calculation manually.
- [ ] **Are the dimensions correct?** Check that GROUP BY and filters match what you asked for.
- [ ] **Are there obvious outliers being ignored?** Claude may average over anomalies without flagging them.
- [ ] **Does the interpretation match the data?** The narrative Claude writes should be supported by the actual numbers, not just plausible-sounding.
- [ ] **Are percentage changes calculated correctly?** (new - old) / old, not the other way around.

---

## For Narratives and Stakeholder Summaries

- [ ] **Are all numbers in the narrative sourced from actual data?** Claude can generate plausible-sounding numbers that don't match your data.
- [ ] **Is the framing accurate?** "Revenue increased 12%" should mean exactly that — check the exact figure.
- [ ] **Are caveats included?** If there are known limitations in the data, did Claude include them or paper over them?
- [ ] **Would your stakeholder have questions you can't answer?** If yes, the summary needs more specificity or caveats.

---

## For Code and Scripts

- [ ] **Does it run without errors?**
- [ ] **Are file paths and environment variables real?** Claude may reference paths or env vars that don't exist on your machine.
- [ ] **Are external dependencies available?** If it imports a library, is that library actually installed?
- [ ] **Does the output match what you expected on a test case?**

---

## Quick Heuristics

| Signal | What it might mean |
|--------|-------------------|
| Column name you don't recognize | Possible hallucination — check schema |
| Row count is exactly 0 or suspiciously round | JOIN or filter issue |
| Numbers are round (e.g., exactly 10,000) | Possible placeholder, not real data |
| "As of [date]" with a date you didn't specify | Claude may be making assumptions |
| Narrative doesn't match your query results | Claude is writing what sounds right, not what the data says |

---

*Remember: Claude Code is a first draft, not a final answer. The eval step is what makes it trustworthy.*
