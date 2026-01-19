
-- Objective:
-- Analyze month-over-month trends in delivered orders
-- to determine whether order volume is declining.

-- Monthly delivered orders
SELECT
    DATE_TRUNC('month', order_date) AS month,
    COUNT(DISTINCT order_id) AS delivered_orders
FROM orders
WHERE order_status = 'delivered'
GROUP BY 1
ORDER BY 1;

-- Month-over-month change in delivered orders
WITH monthly_orders AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        COUNT(DISTINCT order_id) AS delivered_orders
    FROM orders
    WHERE order_status = 'delivered'
    GROUP BY 1
)
SELECT
    month,
    delivered_orders,
    LAG(delivered_orders) OVER (ORDER BY month) AS prev_month_orders,
    ROUND(
        (delivered_orders - LAG(delivered_orders) OVER (ORDER BY month))
        * 100.0 / LAG(delivered_orders) OVER (ORDER BY month),
        2
    ) AS mom_change_pct
FROM monthly_orders
ORDER BY month;
