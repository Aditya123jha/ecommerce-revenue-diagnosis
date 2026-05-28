-- Objective:
-- Segment customers into value tiers using order history and signup data.
-- Identify which customer segments are driving revenue vs. churn risk.
-- Techniques: multi-table JOIN, RANK(), NTILE(), CASE WHEN segmentation

-- STEP 1: Build per-customer metrics by joining orders + users
WITH customer_metrics AS (
    SELECT
        o.user_id,
        u.signup_date,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(o.order_value) AS lifetime_value,
        SUM(CASE WHEN o.order_status = 'delivered'
                 AND o.payment_status = 'success'
                 THEN o.order_value ELSE 0 END) AS realized_value,
        SUM(CASE WHEN o.order_status = 'returned' THEN 1 ELSE 0 END) AS total_returns,
        MAX(o.order_date) AS last_order_date,
        MIN(o.order_date) AS first_order_date,
        -- Days between signup and first order (activation speed)
        MIN(o.order_date) - u.signup_date   AS days_to_first_order
    FROM orders o
    JOIN users u ON o.user_id = u.user_id
    GROUP BY o.user_id, u.signup_date
),

-- STEP 2: Rank customers by lifetime value + assign quartile segments
customer_ranked AS (
    SELECT
        *,
        RANK() OVER (ORDER BY lifetime_value DESC)          AS value_rank,
        NTILE(4) OVER (ORDER BY lifetime_value DESC)        AS value_quartile,
        -- Return rate per customer
        ROUND(total_returns * 100.0 / NULLIF(total_orders, 0), 1) AS return_rate_pct,
        -- Days since last order (recency)
        CURRENT_DATE - last_order_date                      AS days_since_last_order
    FROM customer_metrics
)

-- STEP 3: Final output — segment label + business flag
SELECT
    user_id,
    signup_date,
    total_orders,
    lifetime_value,
    realized_value,
    return_rate_pct,
    value_rank,
    days_since_last_order,
    -- Quartile → human-readable segment
    CASE value_quartile
        WHEN 1 THEN 'Champion'       -- Top 25% by LTV
        WHEN 2 THEN 'Loyal'          -- 26–50%
        WHEN 3 THEN 'At Risk'        -- 51–75%
        WHEN 4 THEN 'Low Value'      -- Bottom 25%
    END AS customer_segment,
    -- Business action flag: high value but recently inactive
    CASE
        WHEN value_quartile = 1 AND days_since_last_order > 45
            THEN 'URGENT: Re-engage — High Value Going Cold'
        WHEN value_quartile = 1 AND return_rate_pct > 30
            THEN 'WATCH: High Value, High Return Risk'
        WHEN value_quartile IN (2,3) AND days_since_last_order > 60
            THEN 'Re-engage — Mid Tier Lapsing'
        ELSE 'Active / Monitor'
    END AS action_flag
FROM customer_ranked
ORDER BY value_rank;
