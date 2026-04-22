# SQL Style Rules — Analyst Template

<!--
  HOW TO USE THIS TEMPLATE
  ========================
  This file becomes your SQL style rules at ~/.claude/rules/sql-style.md
  
  Claude reads all files in ~/.claude/rules/ automatically and applies them
  whenever it writes or reviews SQL for you.
  
  Customize the sections below to match how your team actually works.
  Delete anything that doesn't apply. Add anything that's missing.
  
  The goal: Claude should write SQL that looks like *you* wrote it — not
  like a generic tutorial example.
-->

---

## SQL Formatting

HCP SQL conventions — these are the team defaults. Adjust only if your work requires something different.

- **Keywords in lowercase**: `select`, `from`, `where`, `join`, `left join`, `group by`, `order by`, `with`, `case`, `when`, `then`, `else`, `end`
- **Leading commas**: comma at the start of each new line, not the end
- **One expression per line** in `select`, `group by`, `order by`
- **`where 1=1`**: use so predicates can be toggled with a leading `and`
- **All column references qualified with table aliases**
- **Column aliases in ALL CAPS** with explicit `as`
- **No `right join`** — reorder to use `left join`
- **`count()` for counting**, not `sum(1)`
- **Semicolons**: end every standalone query with a semicolon

```sql
-- HCP style
select
    j.customer_id                       as CUSTOMER_ID
    , c.vertical                        as VERTICAL
    , count(distinct j.id)              as JOB_COUNT
from jobs j
join customers c
    on j.customer_id = c.id
where 1=1
    and j.status = 'completed'
    and j.created_at >= date_trunc('month', current_date)
group by
    j.customer_id
    , c.vertical
order by
    count(distinct j.id) desc
;
```

---

## CTEs vs. Subqueries

**Always prefer CTEs over nested subqueries.**

```sql
-- CORRECT: CTE is readable, testable, modifiable
with active_customers as (
    select
        customer_id
        , vertical
        , created_at
    from customers
    where 1=1
        and status = 'active'
)

select
    vertical                    as VERTICAL
    , count(*)                  as ACTIVE_COUNT
from active_customers
group by
    vertical
;

-- WRONG: nested subquery is harder to debug
select
    vertical                    as VERTICAL
    , count(*)                  as ACTIVE_COUNT
from (
    select customer_id, vertical, created_at
    from customers
    where status = 'active'
) sub
group by vertical
;
```

Name CTEs descriptively — `active_customers`, `monthly_revenue`, `churned_accounts` — not `cte1`, `temp`, `sub`.

---

## Snowflake-Specific Patterns

### Date and time
- Period truncation: `DATE_TRUNC('month', created_at)` for month, `DATE_TRUNC('week', created_at)` for week
- Relative ranges: `DATEADD('day', -30, CURRENT_DATE)` not `CURRENT_DATE - 30`
- Year-over-year comparison: use `DATEADD('year', -1, ...)` for exact YoY, not a hardcoded year
- Timestamp to date: `created_at::DATE` (Snowflake cast syntax)

### NULL handling
- Prefer `COALESCE(column, default_value)` over `CASE WHEN column IS NULL THEN default_value ELSE column END`
- Use `NULLIF(value, 0)` to prevent division-by-zero before dividing: `revenue / NULLIF(orders, 0)`
- Always consider whether a LEFT JOIN can produce unexpected NULLs in downstream columns

### Window functions
- Always specify `ORDER BY` inside window functions when using `ROW_NUMBER()`, `RANK()`, `LAG()`, `LEAD()`
- Use `PARTITION BY` explicitly — never rely on implicit partitioning
- For running totals: `SUM(amount) OVER (PARTITION BY customer_id ORDER BY event_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)`

### Type casting
- Use `::` syntax for casting: `revenue::FLOAT`, `customer_id::VARCHAR`
- Be explicit about types when comparing columns from different source systems

---

## Column Naming

- **snake_case** for all column names: `customer_id`, `created_at`, `monthly_revenue`
- **Descriptive, no abbreviations**: `customer_vertical` not `cust_vert`, `order_count` not `cnt`
- **Consistent suffixes**: `_id` for identifiers, `_at` for timestamps, `_date` for dates, `_count` for counts, `_amount` or `_revenue` for currency
- **Boolean columns**: prefix with `is_` or `has_`: `is_active`, `has_completed_onboarding`
- **Metrics with time context**: include the period in the name where ambiguous: `monthly_active_customers`, `weekly_revenue`

---

## Comment Standards

Comment SQL to explain *why* something works the way it does — not to restate what the code already says.

```sql
-- WRONG: restating the code
-- Filter to active customers
WHERE status = 'active'

-- CORRECT: explaining why this filter is appropriate
-- Exclude churned and trial accounts — they inflate MAU counts
-- per the metric definition in the analytics handbook
WHERE status = 'active'
```

When to comment:
- Business rule embedded in a filter that isn't obvious from the column name
- Non-standard date logic (fiscal calendar, custom week definitions)
- A calculation that has a specific approved definition (e.g., how churn rate is calculated)
- A JOIN that might look wrong but is intentional (e.g., a deliberate LEFT JOIN to capture nulls)

---

## Metric Naming Conventions

<!--
  Fill this section in based on HCP's standard metric definitions.
  These are placeholders — replace with your team's actual conventions.
-->

- **MAU (Monthly Active Users)**: [define what "active" means — transaction, login, or usage event?]
- **Churn rate**: [define whether this is gross or net, and the time window]
- **ARR / MRR**: [define how recognized revenue is counted vs. billed]
- **[Metric name]**: [definition]

When Claude writes a query involving a core metric, it should use the definition above — not infer a definition from the column name.

---

## Performance Awareness

- **Avoid `SELECT *`**: Always specify the columns you need. Star selects pull unnecessary data and make queries harder to understand.
- **Use `LIMIT` for exploration**: When exploring a new table or testing a query, add `LIMIT 100` until you know the shape of the data.
- **Be aware of large table scans**: Snowflake charges by compute time. A full scan of a multi-billion-row events table costs real money. Filter early, filter on partitioned/clustered columns where possible.
- **COUNT(*) before JOINING large tables**: When joining to a table you haven't worked with before, run a `SELECT COUNT(*)` first to understand the scale.
- **Cluster key awareness**: Know which columns your largest Snowflake tables are clustered on — filtering on those columns dramatically reduces scan time.
- **Avoid running expensive queries in loops**: If you're considering a pattern that runs a query inside a loop (in Python or dbt), there's almost always a set-based SQL alternative that's faster.
