-- Objective:
-- Analyze month-over-month trends in delivered orders
-- to determine whether order volume is declining.
-- Fix: NULLIF guard on LAG() to prevent division-by-zero on first month

-- Monthly delivered orders
SELECT
    DATE_TRUNC('month', order_date) AS month,
    COUNT(DISTINCT order_id)        AS delivered_orders
FROM orders
WHERE order_status = 'delivered'
GROUP BY 1
ORDER BY 1;

-- Month-over-month change in delivered orders
-- NULLIF prevents divide-by-zero crash on the first month row
-- where LAG() returns NULL (no previous month exists)

WITH monthly_orders AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        COUNT(DISTINCT order_id)        AS delivered_orders
    FROM orders
    WHERE order_status = 'delivered'
    GROUP BY 1
)
SELECT
    month,
    delivered_orders,
    LAG(delivered_orders) OVER (ORDER BY month)              AS prev_month_orders,
    ROUND(
        (delivered_orders - LAG(delivered_orders) OVER (ORDER BY month))
        * 100.0
        / NULLIF(LAG(delivered_orders) OVER (ORDER BY month), 0),  -- ← fix
        2
    )                                                        AS mom_change_pct
FROM monthly_orders
ORDER BY month;
