SELECT
    order_status,
    COUNT(DISTINCT order_id) AS orders_lost,
    SUM(order_value) AS revenue_lost,
    ROUND(
        SUM(order_value) * 100.0 /
        SUM(SUM(order_value)) OVER (),
        2
    ) AS revenue_loss_pct
FROM orders
WHERE payment_status = 'success'
  AND order_status != 'delivered'
GROUP BY order_status
ORDER BY revenue_lost DESC;
