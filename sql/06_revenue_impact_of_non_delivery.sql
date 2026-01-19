-- Objective:
-- Quantify monthly revenue leakage caused by non-delivered paid orders
-- to understand the true financial impact of operational issues.

-- Key Metrics:
-- Total Paid Revenue
-- Realized Revenue
-- Lost Revenue
-- Revenue Loss Percentage


WITH paid_orders AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        order_id,
        order_status,
        order_value
    FROM orders
    WHERE payment_status = 'success'
),

monthly_revenue AS (
    SELECT
        month,
        SUM(order_value) AS total_paid_revenue,
        SUM(CASE WHEN order_status = 'delivered' THEN order_value ELSE 0 END) AS realized_revenue,
        SUM(CASE WHEN order_status != 'delivered' THEN order_value ELSE 0 END) AS leaked_revenue
    FROM paid_orders
    GROUP BY 1
)

SELECT
    month,
    total_paid_revenue,
    realized_revenue,
    leaked_revenue,
    ROUND(leaked_revenue * 100.0 / total_paid_revenue, 2) AS revenue_leakage_pct
FROM monthly_revenue
ORDER BY month;
