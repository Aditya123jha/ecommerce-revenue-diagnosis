-- Objective:
-- Analyze post-payment order fulfillment to identify
-- operational or logistics-related revenue leakage.
-- ---------------------------------------------------

SELECT
    DATE_TRUNC('month', order_date) AS month,
    COUNT(DISTINCT order_id) AS paid_orders,
    COUNT(DISTINCT CASE WHEN order_status = 'delivered' THEN order_id END) AS delivered_orders,
    COUNT(DISTINCT CASE WHEN order_status != 'delivered' THEN order_id END) AS non_delivered_orders,
    ROUND(
        COUNT(DISTINCT CASE WHEN order_status != 'delivered' THEN order_id END) * 100.0
        / COUNT(DISTINCT order_id),
        2
    ) AS non_delivery_rate_pct
FROM orders
WHERE payment_status = 'success'
GROUP BY 1
ORDER BY month;
