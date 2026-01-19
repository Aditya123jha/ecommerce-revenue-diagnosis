-- Objective:
-- Determine whether revenue decline is driven by
-- order volume or average order value (AOV)

WITH monthly_metrics AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        COUNT(DISTINCT order_id) AS delivered_orders,
        SUM(order_value) AS total_revenue
    FROM orders
    WHERE order_status = 'delivered'
    GROUP BY 1
)
SELECT
    month,
    delivered_orders,
    total_revenue,
    ROUND(total_revenue * 1.0 / delivered_orders, 2) AS aov
FROM monthly_metrics
ORDER BY month;
