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

with month_numbers as (
    select
        row_number() over (order by seq4()) - 1 as N
    from table(generator(rowcount => 6))
)

, date_spine as (
    -- Generate one row per month for the past 6 months
    select
        date_trunc('month', dateadd('month', -n, current_date)) as MONTH_START
    from month_numbers
)

, active_customers as (
    -- A customer is "active" if they completed at least one job in the month
    select
        date_trunc('month', j.job_completed_at)   as MONTH_START
        , c.vertical                              as VERTICAL
        , count(distinct j.customer_id)           as ACTIVE_CUSTOMER_COUNT
    from jobs as j
    join customers as c
        on j.customer_id = c.id
    where 1=1
        and j.status = 'completed'
        and j.job_completed_at >= dateadd('month', -6, current_date)
    group by
        date_trunc('month', j.job_completed_at)
        , c.vertical
)

select
    ds.MONTH_START
    , ac.VERTICAL
    , coalesce(ac.ACTIVE_CUSTOMER_COUNT, 0)       as ACTIVE_CUSTOMERS
    , lag(ac.ACTIVE_CUSTOMER_COUNT) over (
        partition by ac.VERTICAL
        order by ds.MONTH_START
    )                                             as PRIOR_MONTH_ACTIVE_CUSTOMERS
    , round(
        (ac.ACTIVE_CUSTOMER_COUNT - lag(ac.ACTIVE_CUSTOMER_COUNT) over (
            partition by ac.VERTICAL order by ds.MONTH_START
        )) / nullif(lag(ac.ACTIVE_CUSTOMER_COUNT) over (
            partition by ac.VERTICAL order by ds.MONTH_START
        ), 0) * 100
        , 1
    )                                             as MOM_GROWTH_PCT
from date_spine as ds
left join active_customers as ac
    on ds.MONTH_START = ac.MONTH_START
order by
    ds.MONTH_START desc
    , ac.VERTICAL asc
;
