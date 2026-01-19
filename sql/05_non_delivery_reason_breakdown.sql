-- Objective:
-- Break down reasons for non-delivery after successful payment
-- to identify dominant operational failure points.
-- ---------------------------------------------------

WITH non_delivered AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        order_status,
        COUNT(DISTINCT order_id) AS orders_count
    FROM orders
    WHERE payment_status = 'success'
      AND order_status != 'delivered'
    GROUP BY 1, 2
),
monthly_totals AS (
    SELECT
        month,
        SUM(orders_count) AS total_non_delivered
    FROM non_delivered
    GROUP BY 1
)
SELECT
    n.month,
    n.order_status,
    n.orders_count,
    ROUND(
        n.orders_count * 100.0 / m.total_non_delivered,
        2
    ) AS status_pct
FROM non_delivered n
JOIN monthly_totals m
    ON n.month = m.month
ORDER BY n.month, status_pct DESC;
