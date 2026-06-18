-- ============================================================
-- REVENUE ANALYSIS
-- Mobile Sales Analytics Dashboard
-- ============================================================

-- 1. Yearly revenue with YoY growth using LAG
WITH yearly AS (
    SELECT
        year,
        ROUND(SUM(units_sold * price_per_unit), 2) AS revenue,
        SUM(units_sold)                             AS units_sold,
        COUNT(*)                                    AS transactions
    FROM mobile_sales
    GROUP BY year
)
SELECT
    year,
    revenue,
    units_sold,
    transactions,
    LAG(revenue) OVER (ORDER BY year)              AS prev_year_revenue,
    ROUND(
        100.0 * (revenue - LAG(revenue) OVER (ORDER BY year))
              / NULLIF(LAG(revenue) OVER (ORDER BY year), 0), 2
    )                                              AS yoy_growth_pct
FROM yearly
ORDER BY year;

-- 2. Monthly revenue — all periods
SELECT
    year,
    month,
    ROUND(SUM(units_sold * price_per_unit), 2)     AS monthly_revenue,
    SUM(units_sold)                                 AS units_sold,
    COUNT(*)                                        AS transactions,
    ROUND(AVG(units_sold * price_per_unit), 2)      AS avg_transaction_value
FROM mobile_sales
GROUP BY year, month
ORDER BY year, month;

-- 3. Running cumulative revenue by year using window function
WITH monthly AS (
    SELECT
        year,
        month,
        ROUND(SUM(units_sold * price_per_unit), 2) AS monthly_revenue
    FROM mobile_sales
    GROUP BY year, month
)
SELECT
    year,
    month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (
        PARTITION BY year
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )                                              AS cumulative_revenue_ytd
FROM monthly
ORDER BY year, month;

-- 4. Revenue contribution by brand and year
SELECT
    brand,
    year,
    ROUND(SUM(units_sold * price_per_unit), 2)     AS revenue,
    ROUND(
        100.0 * SUM(units_sold * price_per_unit)
              / SUM(SUM(units_sold * price_per_unit)) OVER (PARTITION BY year), 2
    )                                              AS share_of_year_revenue_pct,
    RANK() OVER (
        PARTITION BY year ORDER BY SUM(units_sold * price_per_unit) DESC
    )                                              AS brand_rank_in_year
FROM mobile_sales
GROUP BY brand, year
ORDER BY year, brand_rank_in_year;

-- 5. Revenue quartile analysis — which transactions drive most revenue
WITH transaction_revenue AS (
    SELECT
        transaction_id,
        brand,
        city,
        mobile_model,
        ROUND(units_sold * price_per_unit, 2)      AS revenue,
        NTILE(4) OVER (ORDER BY units_sold * price_per_unit DESC) AS revenue_quartile
    FROM mobile_sales
)
SELECT
    revenue_quartile,
    COUNT(*)                                       AS transactions,
    ROUND(SUM(revenue), 2)                         AS total_revenue,
    ROUND(AVG(revenue), 2)                         AS avg_revenue,
    ROUND(MIN(revenue), 2)                         AS min_revenue,
    ROUND(MAX(revenue), 2)                         AS max_revenue,
    ROUND(
        100.0 * SUM(revenue) / SUM(SUM(revenue)) OVER (), 2
    )                                              AS pct_of_total_revenue
FROM transaction_revenue
GROUP BY revenue_quartile
ORDER BY revenue_quartile;

-- 6. Peak revenue months across all years
SELECT
    month,
    ROUND(SUM(units_sold * price_per_unit), 2)     AS total_revenue_all_years,
    ROUND(AVG(units_sold * price_per_unit), 2)     AS avg_transaction_value,
    COUNT(*)                                        AS total_transactions,
    DENSE_RANK() OVER (
        ORDER BY SUM(units_sold * price_per_unit) DESC
    )                                              AS revenue_rank
FROM mobile_sales
GROUP BY month
ORDER BY revenue_rank;
