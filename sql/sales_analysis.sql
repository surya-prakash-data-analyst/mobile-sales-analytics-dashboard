-- ============================================================
-- SALES ANALYSIS
-- Mobile Sales Analytics Dashboard
-- ============================================================

-- 1. Overall sales KPIs
SELECT
    COUNT(*)                                         AS total_transactions,
    SUM(units_sold)                                  AS total_units_sold,
    ROUND(SUM(units_sold * price_per_unit), 2)       AS total_revenue,
    ROUND(AVG(units_sold * price_per_unit), 2)       AS avg_transaction_value,
    ROUND(AVG(price_per_unit), 2)                    AS avg_price_per_unit,
    ROUND(AVG(customer_ratings), 2)                  AS avg_rating
FROM mobile_sales;

-- 2. Sales by brand — revenue, units, share
WITH brand_totals AS (
    SELECT
        brand,
        SUM(units_sold)                              AS units_sold,
        ROUND(SUM(units_sold * price_per_unit), 2)   AS revenue,
        COUNT(*)                                     AS transactions
    FROM mobile_sales
    GROUP BY brand
),
overall AS (
    SELECT SUM(units_sold * price_per_unit) AS total_rev FROM mobile_sales
)
SELECT
    b.brand,
    b.units_sold,
    b.revenue,
    b.transactions,
    ROUND(100.0 * b.revenue / o.total_rev, 2)        AS revenue_share_pct,
    RANK() OVER (ORDER BY b.revenue DESC)            AS revenue_rank
FROM brand_totals b, overall o
ORDER BY revenue_rank;

-- 3. Sales by city — top 10
SELECT
    city,
    COUNT(*)                                          AS transactions,
    SUM(units_sold)                                   AS units_sold,
    ROUND(SUM(units_sold * price_per_unit), 2)        AS revenue,
    RANK() OVER (ORDER BY SUM(units_sold * price_per_unit) DESC) AS city_rank
FROM mobile_sales
GROUP BY city
ORDER BY revenue DESC
LIMIT 10;

-- 4. Sales by payment method
SELECT
    payment_method,
    COUNT(*)                                          AS transactions,
    SUM(units_sold)                                   AS units_sold,
    ROUND(SUM(units_sold * price_per_unit), 2)        AS revenue,
    ROUND(AVG(customer_ratings), 2)                   AS avg_rating,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS transaction_share_pct
FROM mobile_sales
GROUP BY payment_method
ORDER BY revenue DESC;

-- 5. Brand performance by city — cross-tab using conditional aggregation
SELECT
    city,
    ROUND(SUM(CASE WHEN brand = 'Apple'   THEN units_sold * price_per_unit ELSE 0 END), 0) AS apple_revenue,
    ROUND(SUM(CASE WHEN brand = 'Samsung' THEN units_sold * price_per_unit ELSE 0 END), 0) AS samsung_revenue,
    ROUND(SUM(CASE WHEN brand = 'OnePlus' THEN units_sold * price_per_unit ELSE 0 END), 0) AS oneplus_revenue,
    ROUND(SUM(CASE WHEN brand = 'Vivo'    THEN units_sold * price_per_unit ELSE 0 END), 0) AS vivo_revenue,
    ROUND(SUM(CASE WHEN brand = 'Xiaomi'  THEN units_sold * price_per_unit ELSE 0 END), 0) AS xiaomi_revenue,
    ROUND(SUM(units_sold * price_per_unit), 0)                                              AS total_city_revenue
FROM mobile_sales
GROUP BY city
ORDER BY total_city_revenue DESC;

-- 6. Day-of-week sales pattern
SELECT
    day_name,
    COUNT(*)                                          AS transactions,
    SUM(units_sold)                                   AS units_sold,
    ROUND(SUM(units_sold * price_per_unit), 2)        AS revenue,
    ROUND(AVG(units_sold * price_per_unit), 2)        AS avg_transaction_value
FROM mobile_sales
GROUP BY day_name
ORDER BY revenue DESC;
