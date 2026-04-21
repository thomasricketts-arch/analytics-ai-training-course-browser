# SQL Style Rules — HCP Conventions

## SQL Formatting

- **Keywords in lowercase**: `select`, `from`, `where`, `join`, `left join`, `inner join`, `group by`, `order by`, `having`, `with`, `as`, `on`, `and`, `or`, `not`, `in`, `between`, `case`, `when`, `then`, `else`, `end`, `distinct`, `limit`
- **Leading commas**: comma at the start of each new line in `select`, `group by`, `order by`
- **One expression per line** in `select`, `group by`, `order by`
- **Column aliases in ALL CAPS** with explicit `as`
- **`where 1=1`** so predicates can be toggled with a leading `and`
- **Qualify all column references** with table aliases — no bare column names
- **Semicolons**: end every standalone query with a semicolon

```sql
-- CORRECT
select
    o.organization_id
    , o.name                    as ORG_NAME
    , count(distinct j.job_id)  as TOTAL_JOBS
from analytics.main.dim_organization as o
left join analytics.main.fact_job as j
    on o.organization_id = j.organization_id
where 1=1
    and o.status = 'active'
    and j.created_date >= '2025-01-01'
group by
    o.organization_id
    , o.name
order by
    TOTAL_JOBS desc
;
```

---

## CTEs vs. Subqueries

**Always prefer CTEs over nested subqueries.**

Name CTEs descriptively — `active_customers`, `monthly_revenue`, `churned_accounts` — not `cte1`, `temp`, `sub`.

```sql
-- CORRECT
with active_customers as (
    select
        c.customer_id
        , c.vertical
    from customers as c
    where 1=1
        and c.status = 'active'
)

select
    ac.vertical
    , count(distinct ac.customer_id) as ACTIVE_COUNT
from active_customers as ac
group by
    ac.vertical
;
```

---

## Joins

- **Never use `right join`** — reorder the query to use `left join` instead
- Always specify the join type explicitly — never use implicit joins
- Always join on qualified column references

---

## Counting

- Use `count()` for counting — never `sum(1)`
- Use `count(distinct column)` when deduplication is needed

---

## NULL Handling

- Prefer `coalesce(column, default_value)` over `case when column is null then default_value else column end`
- Use `nullif(value, 0)` to prevent division-by-zero: `revenue / nullif(orders, 0)`
- Note: `least()`, `greatest()`, `||`, and `concat()` are **not** null-safe in Snowflake — flag any usage
- Always consider whether a `left join` can produce unexpected nulls in downstream columns

---

## Snowflake-Specific Patterns

- Period truncation: `date_trunc('month', created_at)`
- Relative ranges: `dateadd('day', -30, current_date)` — not `current_date - 30`
- Timestamp to date: `created_at::date`
- Type casting: `revenue::float`, `customer_id::varchar`

---

## Column Naming

- **snake_case** for all column names
- **Consistent suffixes**: `_id` for identifiers, `_at` for timestamps, `_date` for dates, `_count` for counts, `_amount` for currency
- **Boolean columns**: prefix with `is_` or `has_`: `is_active`, `has_completed_onboarding`

---

## Performance

- Never use `select *` — always specify the columns you need
- Add `limit 100` for exploratory queries; remove before anything goes into a dashboard or report
- Run `select count(*)` before joining to an unfamiliar large table
- Filter early, and filter on clustered/partitioned columns where possible

---

## Comments

Comment to explain *why*, not *what*:

```sql
-- WRONG: restating the code
-- Filter to active customers
where 1=1
    and status = 'active'

-- CORRECT: explaining the business rule
-- Exclude churned and trial accounts — they inflate MAU per analytics handbook definition
where 1=1
    and status = 'active'
```
