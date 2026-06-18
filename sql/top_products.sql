-- ============================================================
-- TOP PRODUCTS ANALYSIS
-- Mobile Sales Analytics Dashboard
-- ============================================================

-- 1. Top models by total revenue with ranking
SELECT
    mobile_model,
    brand,
    COUNT(*)                                       AS transactions,
    SUM(units_sold)                                AS total_units,
    ROUND(SUM(units_sold * price_per_unit), 2)     AS revenue,
    ROUND(AVG(price_per_unit), 2)                  AS avg_price,
    ROUND(AVG(customer_ratings), 2)                AS avg_rating,
    RANK() OVER (ORDER BY SUM(units_sold * price_per_unit) DESC)       AS revenue_rank,
    DENSE_RANK() OVER (ORDER BY SUM(units_sold) DESC)                  AS volume_rank
FROM mobile_sales
GROUP BY mobile_model, brand
ORDER BY revenue_rank
LIMIT 20;

-- 2. Top model per brand using CTE + window function
WITH model_brand AS (
    SELECT
        brand,
        mobile_model,
        ROUND(SUM(units_sold * price_per_unit), 2)   AS revenue,
        SUM(units_sold)                               AS units_sold,
        ROUND(AVG(customer_ratings), 2)               AS avg_rating,
        RANK() OVER (
            PARTITION BY brand
            ORDER BY SUM(units_sold * price_per_unit) DESC
        )                                             AS model_rank_in_brand
    FROM mobile_sales
    GROUP BY brand, mobile_model
)
SELECT
    brand,
    mobile_model,
    revenue,
    units_sold,
    avg_rating,
    model_rank_in_brand
FROM model_brand
WHERE model_rank_in_brand <= 3
ORDER BY brand, model_rank_in_brand;

-- 3. Model performance by city — identify geography-specific bestsellers
WITH model_city AS (
    SELECT
        city,
        mobile_model,
        brand,
        ROUND(SUM(units_sold * price_per_unit), 2)   AS revenue,
        SUM(units_sold)                               AS units_sold,
        RANK() OVER (
            PARTITION BY city
            ORDER BY SUM(units_sold * price_per_unit) DESC
        )                                             AS city_rank
    FROM mobile_sales
    GROUP BY city, mobile_model, brand
)
SELECT
    city,
    mobile_model,
    brand,
    revenue,
    units_sold
FROM model_city
WHERE city_rank = 1
ORDER BY revenue DESC;

-- 4. Revenue share of top 5 vs rest
WITH model_rev AS (
    SELECT
        mobile_model,
        ROUND(SUM(units_sold * price_per_unit), 2)   AS revenue,
        RANK() OVER (ORDER BY SUM(units_sold * price_per_unit) DESC) AS rnk
    FROM mobile_sales
    GROUP BY mobile_model
)
SELECT
    CASE WHEN rnk <= 5 THEN mobile_model ELSE 'All Other Models' END AS model_group,
    ROUND(SUM(revenue), 2)                                            AS revenue,
    ROUND(
        100.0 * SUM(revenue) / SUM(SUM(revenue)) OVER (), 2
    )                                                                 AS revenue_share_pct
FROM model_rev
GROUP BY model_group
ORDER BY revenue DESC;

-- 5. Price band analysis using CASE WHEN
SELECT
    CASE
        WHEN price_per_unit < 20000 THEN 'Budget (< ₹20K)'
        WHEN price_per_unit < 40000 THEN 'Mid-Range (₹20K–40K)'
        WHEN price_per_unit < 60000 THEN 'Premium (₹40K–60K)'
        ELSE 'Ultra Premium (₹60K+)'
    END                                            AS price_band,
    COUNT(*)                                       AS transactions,
    SUM(units_sold)                                AS units_sold,
    ROUND(SUM(units_sold * price_per_unit), 2)     AS revenue,
    ROUND(AVG(customer_ratings), 2)                AS avg_rating,
    ROUND(
        100.0 * SUM(units_sold * price_per_unit)
              / SUM(SUM(units_sold * price_per_unit)) OVER (), 2
    )                                              AS revenue_share_pct
FROM mobile_sales
GROUP BY price_band
ORDER BY revenue DESC;

-- 6. Model trend — is each model growing or shrinking by year
WITH model_year AS (
    SELECT
        mobile_model,
        year,
        ROUND(SUM(units_sold * price_per_unit), 2) AS revenue
    FROM mobile_sales
    GROUP BY mobile_model, year
)
SELECT
    mobile_model,
    year,
    revenue,
    LAG(revenue) OVER (PARTITION BY mobile_model ORDER BY year) AS prev_year_revenue,
    ROUND(
        100.0 * (revenue - LAG(revenue) OVER (PARTITION BY mobile_model ORDER BY year))
              / NULLIF(LAG(revenue) OVER (PARTITION BY mobile_model ORDER BY year), 0), 2
    )                                              AS yoy_growth_pct
FROM model_year
ORDER BY mobile_model, year;
