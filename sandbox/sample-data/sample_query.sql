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

WITH date_spine AS (
    -- Generate one row per month for the past 6 months
    SELECT
        DATE_TRUNC('month', DATEADD('month', -n, CURRENT_DATE)) AS month_start
    FROM (
        SELECT ROW_NUMBER() OVER (ORDER BY SEQ4()) - 1 AS n
        FROM TABLE(GENERATOR(ROWCOUNT => 6))
    )
),

active_customers AS (
    -- A customer is "active" if they completed at least one job in the month
    SELECT
        DATE_TRUNC('month', job_completed_at)   AS month_start,
        c.vertical                              AS vertical,
        COUNT(DISTINCT j.customer_id)           AS active_customer_count
    FROM jobs j
    JOIN customers c
        ON j.customer_id = c.id
    WHERE
        j.status        = 'completed'
        AND j.job_completed_at >= DATEADD('month', -6, CURRENT_DATE)
    GROUP BY 1, 2
)

SELECT
    ds.month_start,
    ac.vertical,
    COALESCE(ac.active_customer_count, 0)   AS active_customers,
    LAG(ac.active_customer_count) OVER (
        PARTITION BY ac.vertical
        ORDER BY ds.month_start
    )                                       AS prior_month_active_customers,
    ROUND(
        (ac.active_customer_count - LAG(ac.active_customer_count) OVER (
            PARTITION BY ac.vertical ORDER BY ds.month_start
        )) / NULLIF(LAG(ac.active_customer_count) OVER (
            PARTITION BY ac.vertical ORDER BY ds.month_start
        ), 0) * 100,
        1
    )                                       AS mom_growth_pct
FROM date_spine ds
LEFT JOIN active_customers ac
    ON ds.month_start = ac.month_start
ORDER BY
    ds.month_start DESC,
    ac.vertical ASC
;
