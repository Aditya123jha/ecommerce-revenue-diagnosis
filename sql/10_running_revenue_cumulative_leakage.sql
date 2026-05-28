-- Objective:
-- Track cumulative revenue and leakage over time.
-- Identify the single worst month for leakage and benchmark every
-- other month against it.
-- Techniques: SUM() OVER (ORDER BY) running total, FIRST_VALUE(),
--             LAST_VALUE(), ROUND, NULLIF, pct-vs-peak benchmark

-- STEP 1: Monthly revenue and leakage base
WITH monthly_base AS (
    SELECT
        DATE_TRUNC('month', order_date)                              AS month,
        SUM(order_value)                                             AS total_paid_revenue,
        SUM(CASE WHEN order_status = 'delivered'
                 THEN order_value ELSE 0 END)                        AS realized_revenue,
        SUM(CASE WHEN order_status != 'delivered'
                 THEN order_value ELSE 0 END)                        AS leaked_revenue,
        COUNT(DISTINCT order_id)                                     AS total_orders,
        COUNT(DISTINCT CASE WHEN order_status = 'delivered'
                            THEN order_id END)                       AS delivered_orders
    FROM orders
    WHERE payment_status = 'success'
    GROUP BY 1
),

-- STEP 2: Add running totals + window-level benchmarks
monthly_with_running AS (
    SELECT
        month,
        total_paid_revenue,
        realized_revenue,
        leaked_revenue,
        total_orders,
        delivered_orders,

        -- Leakage rate this month
        ROUND(leaked_revenue * 100.0 / NULLIF(total_paid_revenue, 0), 2)
            AS leakage_rate_pct,

        -- Running cumulative paid revenue (all months up to this one)
        SUM(total_paid_revenue) OVER (ORDER BY month ROWS UNBOUNDED PRECEDING)
            AS cumulative_paid_revenue,

        -- Running cumulative leakage
        SUM(leaked_revenue) OVER (ORDER BY month ROWS UNBOUNDED PRECEDING)
            AS cumulative_leaked_revenue,

        -- Running cumulative realized revenue
        SUM(realized_revenue) OVER (ORDER BY month ROWS UNBOUNDED PRECEDING)
            AS cumulative_realized_revenue,

        -- Month with highest leakage across entire window (for benchmarking)
        FIRST_VALUE(month) OVER (
            ORDER BY leaked_revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS worst_leakage_month,

        -- Actual worst-month leakage value (for % comparison)
        FIRST_VALUE(leaked_revenue) OVER (
            ORDER BY leaked_revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS worst_month_leakage_value,

        -- Month with best (lowest) leakage rate
        FIRST_VALUE(month) OVER (
            ORDER BY leaked_revenue ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS best_leakage_month
    FROM monthly_base
)

-- STEP 3: Final output with benchmark column
SELECT
    month,
    total_paid_revenue,
    realized_revenue,
    leaked_revenue,
    leakage_rate_pct,
    cumulative_paid_revenue,
    cumulative_leaked_revenue,

    -- Cumulative leakage as % of cumulative paid (overall health metric)
    ROUND(
        cumulative_leaked_revenue * 100.0 / NULLIF(cumulative_paid_revenue, 0),
        2
    ) AS cumulative_leakage_rate_pct,

    -- How does this month's leakage compare to the worst month? (100% = worst month)
    ROUND(
        leaked_revenue * 100.0 / NULLIF(worst_month_leakage_value, 0),
        1
    ) AS pct_of_worst_month,

    -- Flag worst and best months clearly
    CASE
        WHEN month = worst_leakage_month THEN '⚠ Worst Leakage Month'
        WHEN month = best_leakage_month  THEN '✓ Best Leakage Month'
        ELSE '—'
    END AS month_flag

FROM monthly_with_running
ORDER BY month;
