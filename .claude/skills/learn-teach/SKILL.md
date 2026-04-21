---
name: learn-teach
description: "Step-by-step explanation of a SQL or analytics concept with progressive depth. Use: /learn:teach <concept>"
---

# Teach Me

Step-by-step explanation of a SQL or analytics concept, building from a simple definition to a practical example you can use in your own work.

## Usage

```
/learn:teach window functions        # Learn about SQL window functions
/learn:teach CTEs                    # Understand common table expressions
/learn:teach DATE_TRUNC              # Snowflake date truncation
/learn:teach QUALIFY                 # Snowflake's row-filtering clause
/learn:teach --deep LAG              # In-depth explanation with edge cases
/learn:teach --quick COALESCE        # Quick definition only
```

## Instructions

1. Start with a **one-sentence definition** of the concept
2. Explain **why it matters** (the real analyst problem it solves)
3. Show a **minimal example** (simplest possible SQL — nothing extra)
4. Break down **each part** with inline comments
5. Show a **practical example** (a realistic analyst use case)
6. Highlight **common mistakes** analysts make with this concept
7. Suggest **what to learn next**

## Response Format

```markdown
## [Concept Name]

**In one sentence**: [Clear, plain-language definition]

### Why It Matters

[1-2 sentences on the real problem this solves for an analyst]

### Minimal Example

\`\`\`sql
-- Simplest possible demonstration
[sql]
\`\`\`

**Line by line**:
- [clause or line]: [explanation]
- [clause or line]: [explanation]

### Practical Example

\`\`\`sql
-- Real analyst use case
[sql]
\`\`\`

[1-2 sentences explaining what this query does and when you'd use it]

### Common Mistakes

1. **[Mistake]**: [Why it's wrong and what to do instead]
2. **[Mistake]**: [Why it's wrong and what to do instead]

### Key Takeaways

- [Bullet point 1]
- [Bullet point 2]
- [Bullet point 3]

### Learn Next

- [Related concept 1] — [why it connects]
- [Related concept 2] — [why it connects]

---

**Practice challenge**: [Small SQL exercise to reinforce the concept]
```

## Depth Modes

### Default
- One-sentence definition
- One minimal SQL example with line-by-line breakdown
- One practical analyst example
- 2-3 common mistakes

### `--deep`
- Extended explanation with context on why the feature exists
- Multiple examples of increasing complexity
- Edge cases and Snowflake-specific gotchas
- Performance implications (partition size, ordering cost, etc.)
- Comparison with alternative approaches

### `--quick`
- Definition only
- Single example
- No extras

## Adaptation Rules

### For Beginners
- Use analogies from spreadsheets or Excel when possible
- Explain SQL keywords before using them
- More inline comments in code examples
- Start with the simplest version, not the most powerful one

### For Intermediates
- Focus on "why this approach" over just "what it does"
- Include trade-offs vs. alternatives (e.g. subquery vs CTE)
- Show idiomatic patterns used by experienced analysts

### For Advanced Topics
- Cover performance implications (Snowflake query profile, partition pruning)
- Discuss edge cases: NULLs, empty partitions, tie-handling in ranking
- Reference Snowflake documentation patterns where relevant

## Topics Well-Suited for /learn:teach

| Category | Examples |
|----------|---------|
| **Window Functions** | ROW_NUMBER, RANK, DENSE_RANK, LAG, LEAD, FIRST_VALUE, NTILE, SUM OVER |
| **CTEs** | basic CTEs, chaining multiple CTEs, when to use CTEs vs subqueries |
| **Aggregations** | GROUP BY gotchas, HAVING vs WHERE, COUNT DISTINCT, APPROX_COUNT_DISTINCT |
| **Snowflake-specific** | QUALIFY, DATE_TRUNC, DATEADD, DATEDIFF, FLATTEN, ARRAY_AGG, OBJECT_CONSTRUCT |
| **Date Logic** | date ranges, fiscal periods, timezone handling, BETWEEN gotchas |
| **NULL Handling** | COALESCE, NULLIF, IS NULL vs = NULL, NULLs in aggregations and JOINs |
| **Joins** | LEFT vs INNER, fanout from one-to-many, self-joins, anti-joins |
| **Deduplication** | ROW_NUMBER dedup pattern, QUALIFY dedup, DISTINCT gotchas |
| **Data Modeling** | grain, surrogate keys, slowly changing dimensions, bridge tables |
| **Python / pandas** | groupby, merge, pivot_table, apply, method chaining |

$ARGUMENTS
