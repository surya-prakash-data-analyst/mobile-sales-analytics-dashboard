-- ============================================================
-- CUSTOMER SEGMENTATION
-- Mobile Sales Analytics Dashboard
-- ============================================================

-- 1. Age group segmentation using CASE WHEN
SELECT
    CASE
        WHEN customer_age BETWEEN 18 AND 25 THEN '18-25'
        WHEN customer_age BETWEEN 26 AND 35 THEN '26-35'
        WHEN customer_age BETWEEN 36 AND 45 THEN '36-45'
        WHEN customer_age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END                                             AS age_group,
    COUNT(*)                                        AS transactions,
    SUM(units_sold)                                 AS units_sold,
    ROUND(SUM(units_sold * price_per_unit), 2)      AS revenue,
    ROUND(AVG(units_sold * price_per_unit), 2)      AS avg_transaction_value,
    ROUND(AVG(customer_ratings), 2)                 AS avg_rating,
    ROUND(
        100.0 * SUM(units_sold * price_per_unit)
              / SUM(SUM(units_sold * price_per_unit)) OVER (), 2
    )                                               AS revenue_share_pct
FROM mobile_sales
GROUP BY age_group
ORDER BY revenue DESC;

-- 2. Age group × brand preference — which segment buys which brand
SELECT
    CASE
        WHEN customer_age BETWEEN 18 AND 25 THEN '18-25'
        WHEN customer_age BETWEEN 26 AND 35 THEN '26-35'
        WHEN customer_age BETWEEN 36 AND 45 THEN '36-45'
        WHEN customer_age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END                                             AS age_group,
    brand,
    COUNT(*)                                        AS transactions,
    ROUND(SUM(units_sold * price_per_unit), 2)      AS revenue,
    RANK() OVER (
        PARTITION BY
            CASE
                WHEN customer_age BETWEEN 18 AND 25 THEN '18-25'
                WHEN customer_age BETWEEN 26 AND 35 THEN '26-35'
                WHEN customer_age BETWEEN 36 AND 45 THEN '36-45'
                WHEN customer_age BETWEEN 46 AND 60 THEN '46-60'
                ELSE '60+'
            END
        ORDER BY SUM(units_sold * price_per_unit) DESC
    )                                               AS brand_rank_in_segment
FROM mobile_sales
GROUP BY age_group, brand
ORDER BY age_group, brand_rank_in_segment;

-- 3. Customer value tier using NTILE
WITH customer_transactions AS (
    SELECT
        customer_name,
        customer_age,
        city,
        COUNT(*)                                    AS transaction_count,
        SUM(units_sold)                             AS total_units,
        ROUND(SUM(units_sold * price_per_unit), 2)  AS total_revenue,
        ROUND(AVG(customer_ratings), 2)             AS avg_rating
    FROM mobile_sales
    GROUP BY customer_name, customer_age, city
)
SELECT
    customer_name,
    customer_age,
    city,
    transaction_count,
    total_revenue,
    avg_rating,
    NTILE(4) OVER (ORDER BY total_revenue DESC)    AS value_quartile,
    CASE
        WHEN NTILE(4) OVER (ORDER BY total_revenue DESC) = 1 THEN 'Premium'
        WHEN NTILE(4) OVER (ORDER BY total_revenue DESC) = 2 THEN 'High Value'
        WHEN NTILE(4) OVER (ORDER BY total_revenue DESC) = 3 THEN 'Mid Value'
        ELSE 'Standard'
    END                                            AS customer_tier
FROM customer_transactions
ORDER BY total_revenue DESC;

-- 4. Payment method × age group cross-analysis
SELECT
    payment_method,
    CASE
        WHEN customer_age BETWEEN 18 AND 35 THEN 'Young (18-35)'
        WHEN customer_age BETWEEN 36 AND 55 THEN 'Mid (36-55)'
        ELSE 'Senior (55+)'
    END                                            AS age_band,
    COUNT(*)                                       AS transactions,
    ROUND(SUM(units_sold * price_per_unit), 2)     AS revenue,
    ROUND(AVG(customer_ratings), 2)                AS avg_rating
FROM mobile_sales
GROUP BY payment_method, age_band
ORDER BY payment_method, revenue DESC;

-- 5. High-value customer profile — top 10% spenders
WITH pct_ranked AS (
    SELECT
        customer_name,
        customer_age,
        city,
        brand,
        payment_method,
        ROUND(SUM(units_sold * price_per_unit), 2) AS total_revenue,
        ROUND(AVG(customer_ratings), 2)            AS avg_rating,
        NTILE(10) OVER (ORDER BY SUM(units_sold * price_per_unit) DESC) AS decile
    FROM mobile_sales
    GROUP BY customer_name, customer_age, city, brand, payment_method
)
SELECT
    customer_name,
    customer_age,
    city,
    brand,
    payment_method,
    total_revenue,
    avg_rating
FROM pct_ranked
WHERE decile = 1
ORDER BY total_revenue DESC;

-- 6. Rating distribution with revenue breakdown
SELECT
    customer_ratings,
    COUNT(*)                                       AS transactions,
    ROUND(SUM(units_sold * price_per_unit), 2)     AS revenue,
    ROUND(AVG(units_sold * price_per_unit), 2)     AS avg_transaction_value,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_transactions
FROM mobile_sales
GROUP BY customer_ratings
ORDER BY customer_ratings;
