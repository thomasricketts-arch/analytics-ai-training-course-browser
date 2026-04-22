-- ============================================================
-- Sample Query: Monthly Active Customers by Vertical
-- ============================================================
--
-- Purpose: Count distinct active customers per month,
--          broken out by business vertical, for the past 6 months.
--
-- Used in: Exercise 01 — ask Claude to read this file and explain it.
--
-- NOTE: This query uses a generic schema for learning purposes.
--       Column names and table names are illustrative, not real HCP tables.
--
-- ============================================================

with date_spine as (
    -- Generate one row per month for the past 6 months
    select
        date_trunc('month', dateadd('month', -n, current_date)) as MONTH_START
    from (
        select row_number() over (order by seq4()) - 1 as n
        from table(generator(rowcount => 6))
    )
)

, active_customers as (
    -- A customer is "active" if they completed at least one job in the month
    select
        date_trunc('month', j.job_completed_at)   as MONTH_START
        , c.vertical                              as VERTICAL
        , count(distinct j.customer_id)           as ACTIVE_CUSTOMER_COUNT
    from jobs j
    join customers c
        on j.customer_id = c.id
    where 1=1
        and j.status = 'completed'
        and j.job_completed_at >= dateadd('month', -6, current_date)
    group by
        date_trunc('month', j.job_completed_at)
        , c.vertical
)

select
    ds.month_start                          as MONTH_START
    , ac.vertical                           as VERTICAL
    , coalesce(ac.active_customer_count, 0) as ACTIVE_CUSTOMERS
    , lag(ac.active_customer_count) over (
        partition by ac.vertical
        order by ds.month_start
    )                                       as PRIOR_MONTH_ACTIVE_CUSTOMERS
    , round(
        (ac.active_customer_count - lag(ac.active_customer_count) over (
            partition by ac.vertical order by ds.month_start
        )) / nullif(lag(ac.active_customer_count) over (
            partition by ac.vertical order by ds.month_start
        ), 0) * 100
        , 1
    )                                       as MOM_GROWTH_PCT
from date_spine ds
left join active_customers ac
    on ds.month_start = ac.month_start
order by
    ds.month_start desc
    , ac.vertical asc
;
