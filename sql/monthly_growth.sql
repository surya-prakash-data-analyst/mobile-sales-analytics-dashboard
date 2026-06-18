-- ============================================================
-- MONTHLY GROWTH ANALYSIS
-- Mobile Sales Analytics Dashboard
-- ============================================================

-- 1. Month-over-month revenue growth using LAG
WITH monthly_revenue AS (
    SELECT
        year,
        month,
        ROUND(SUM(units_sold * price_per_unit), 2) AS revenue,
        SUM(units_sold)                             AS units_sold,
        COUNT(*)                                    AS transactions
    FROM mobile_sales
    GROUP BY year, month
)
SELECT
    year,
    month,
    revenue,
    units_sold,
    transactions,
    LAG(revenue) OVER (ORDER BY year, month)       AS prev_month_revenue,
    ROUND(
        100.0 * (revenue - LAG(revenue) OVER (ORDER BY year, month))
              / NULLIF(LAG(revenue) OVER (ORDER BY year, month), 0), 2
    )                                              AS mom_growth_pct,
    -- 3-month rolling average
    ROUND(
        AVG(revenue) OVER (
            ORDER BY year, month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2
    )                                              AS rolling_3mo_avg
FROM monthly_revenue
ORDER BY year, month;

-- 2. Same-month year-over-year comparison
WITH monthly AS (
    SELECT
        year,
        month,
        ROUND(SUM(units_sold * price_per_unit), 2) AS revenue
    FROM mobile_sales
    GROUP BY year, month
)
SELECT
    a.month,
    a.year                                         AS current_year,
    a.revenue                                      AS current_revenue,
    b.year                                         AS prior_year,
    b.revenue                                      AS prior_revenue,
    ROUND(
        100.0 * (a.revenue - b.revenue) / NULLIF(b.revenue, 0), 2
    )                                              AS yoy_change_pct
FROM monthly a
JOIN monthly b ON a.month = b.month AND a.year = b.year + 1
ORDER BY a.year, a.month;

-- 3. Best and worst performing months (all time)
WITH monthly AS (
    SELECT
        year,
        month,
        ROUND(SUM(units_sold * price_per_unit), 2) AS revenue
    FROM mobile_sales
    GROUP BY year, month
)
SELECT
    year,
    month,
    revenue,
    RANK() OVER (ORDER BY revenue DESC)            AS revenue_rank,
    CASE
        WHEN RANK() OVER (ORDER BY revenue DESC) <= 5  THEN 'Top 5 Month'
        WHEN RANK() OVER (ORDER BY revenue DESC) >= (SELECT COUNT(*) - 4 FROM monthly) THEN 'Bottom 5 Month'
        ELSE 'Average'
    END                                            AS performance_label
FROM monthly
ORDER BY revenue DESC;

-- 4. Quarterly revenue summary using CASE WHEN
SELECT
    year,
    CASE
        WHEN month IN (1, 2, 3)   THEN 'Q1'
        WHEN month IN (4, 5, 6)   THEN 'Q2'
        WHEN month IN (7, 8, 9)   THEN 'Q3'
        WHEN month IN (10, 11, 12) THEN 'Q4'
    END                                            AS quarter,
    ROUND(SUM(units_sold * price_per_unit), 2)     AS quarterly_revenue,
    SUM(units_sold)                                AS units_sold,
    COUNT(*)                                       AS transactions,
    ROUND(AVG(units_sold * price_per_unit), 2)     AS avg_transaction_value
FROM mobile_sales
GROUP BY year, quarter
ORDER BY year, quarter;

-- 5. Revenue acceleration — is growth speeding up or slowing down?
WITH monthly AS (
    SELECT
        year, month,
        ROUND(SUM(units_sold * price_per_unit), 2) AS revenue
    FROM mobile_sales
    GROUP BY year, month
),
growth AS (
    SELECT
        year, month, revenue,
        ROUND(
            100.0 * (revenue - LAG(revenue) OVER (ORDER BY year, month))
                  / NULLIF(LAG(revenue) OVER (ORDER BY year, month), 0), 2
        ) AS mom_growth_pct
    FROM monthly
)
SELECT
    year, month, revenue, mom_growth_pct,
    mom_growth_pct - LAG(mom_growth_pct) OVER (ORDER BY year, month) AS growth_acceleration,
    CASE
        WHEN mom_growth_pct > 5  THEN 'Strong Growth'
        WHEN mom_growth_pct > 0  THEN 'Mild Growth'
        WHEN mom_growth_pct = 0  THEN 'Flat'
        WHEN mom_growth_pct > -5 THEN 'Mild Decline'
        ELSE 'Significant Decline'
    END                                            AS growth_label
FROM growth
ORDER BY year, month;
