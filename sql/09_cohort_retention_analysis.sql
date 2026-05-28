-- Objective:
-- Analyze customer retention by signup cohort.
-- For each monthly cohort, track what % of customers placed orders
-- in subsequent months — identifying where customers drop off.
-- Techniques: cohort join, DATE_TRUNC, EXTRACT interval, NULLIF,
--             SUM() OVER (PARTITION BY), conditional aggregation

-- STEP 1: Assign each user to their signup cohort (month of signup)
WITH cohort_base AS (
    SELECT
        user_id,
        DATE_TRUNC('month', signup_date) AS cohort_month
    FROM users
),

-- STEP 2: For each order, calculate how many months after signup it occurred
order_activity AS (
    SELECT
        o.user_id,
        c.cohort_month,
        DATE_TRUNC('month', o.order_date)                          AS order_month,
        -- Month number since cohort start (0 = same month as signup)
        EXTRACT(YEAR FROM AGE(
            DATE_TRUNC('month', o.order_date),
            c.cohort_month
        )) * 12 +
        EXTRACT(MONTH FROM AGE(
            DATE_TRUNC('month', o.order_date),
            c.cohort_month
        ))                                                         AS month_number
    FROM orders o
    JOIN cohort_base c ON o.user_id = c.user_id
    WHERE o.payment_status = 'success'
),
  
-- STEP 3: Count distinct active users per cohort per month
cohort_activity AS (
    SELECT
        cohort_month,
        month_number,
        COUNT(DISTINCT user_id) AS active_users
    FROM order_activity
    GROUP BY cohort_month, month_number
),

-- STEP 4: Get cohort size (users active in month 0 = first-ever order)
cohort_size AS (
    SELECT
        cohort_month,
        active_users AS cohort_size
    FROM cohort_activity
    WHERE month_number = 0
)

-- STEP 5: Final retention table — % retained per cohort per month
SELECT
    ca.cohort_month,
    ca.month_number,
    ca.active_users,
    cs.cohort_size,
    ROUND(
        ca.active_users * 100.0 / NULLIF(cs.cohort_size, 0),
        1
    ) AS retention_pct,
    -- Running cumulative users lost since cohort start
    cs.cohort_size - ca.active_users AS users_lost_vs_cohort_start
FROM cohort_activity ca
JOIN cohort_size cs ON ca.cohort_month = cs.cohort_month
ORDER BY ca.cohort_month, ca.month_number;

-- BUSINESS INTERPRETATION GUIDE
-- month_number = 0  → same month as signup (baseline = 100%)
-- month_number = 1  → 1 month after signup
-- month_number = 2  → 2 months after signup
--
-- If retention_pct drops sharply from month 0 → month 1:
--   → First-order experience is failing (packaging, delivery speed, product quality)
-- If retention_pct is flat from month 2 onwards at a low number:
--   → Platform has a loyalty problem, not an acquisition problem
