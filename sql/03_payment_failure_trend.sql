-- Objective:
-- Analyze monthly payment failures to determine whether
-- failed payments are contributing to revenue decline

SELECT
    DATE_TRUNC('month', order_date) AS month,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT CASE WHEN payment_status = 'failed' THEN order_id END) AS failed_payments,
    ROUND(
        COUNT(DISTINCT CASE WHEN payment_status = 'failed' THEN order_id END) * 100.0
        / COUNT(DISTINCT order_id),
        2
    ) AS failed_payment_pct
FROM orders
GROUP BY 1
ORDER BY month;
