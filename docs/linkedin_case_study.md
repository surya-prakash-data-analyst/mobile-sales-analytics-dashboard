# LinkedIn Case Study — Mobile Sales Analytics Dashboard

*How I turned three years of scattered Excel sales data into a ₹769M revenue intelligence system.*

---

## The Problem

A mobile device retailer had transaction records going back to late 2021 — brand, model, city, customer age, payment method, units sold, price — sitting in an Excel file that nobody had ever systematically analyzed.

The business was making inventory decisions based on what sold last month. Marketing was running campaigns without knowing which customer segment actually drove revenue. And leadership had no clear answer to a straightforward question: why did revenue decline in 2023 after a strong 2022?

I was brought in to build an analytics framework that could answer these questions and keep answering them as new data came in.

---

## The Approach

I started by understanding the data before touching any tool. 3,835 transactions, 14 columns, October 2021 through October 2024. No missing values, which is rare and appreciated. The only derived field needed was `Revenue = Units Sold × Price Per Unit` — everything else was already there.

From there I ran Python EDA using Pandas and Seaborn to get an unfiltered view of the data: revenue by brand, city, model, age group, payment method, and year. No assumptions going in — just let the numbers show what they show.

The SQL layer came next. I built five scripts covering revenue analysis with LAG-based YoY comparisons, customer segmentation using NTILE and CASE WHEN age bands, product rankings with RANK and DENSE_RANK partitioned by brand, monthly growth trends with rolling averages, and cohort analysis. The goal was a set of repeatable queries that any analyst could run against updated data without rebuilding anything.

Finally, the Power BI dashboard brought everything together into a format that non-analysts could use. KPI cards at the top, brand and city charts in the middle, model rankings and payment breakdown below. Slicers for year, brand, and city so any stakeholder can filter to their question without asking the analytics team.

---

## What the Analysis Found

The headline number is ₹769M in total revenue — but that masks a more interesting story underneath.

**The market is more fragmented than anyone expected.** All five brands — Apple, Samsung, OnePlus, Vivo, Xiaomi — sit within 12% of each other by revenue share. Apple leads at 21.0%, Xiaomi trails at 18.7%. There is no dominant brand. That means inventory diversification is not just defensible, it's correct.

**Revenue has been declining since 2022.** The business peaked at ₹262M that year, dropped 3.3% to ₹253M in 2023, and is tracking toward roughly ₹215–220M annualized in 2024. That trajectory needed explaining. The data points to a mix of factors: the 2022 number may have been partially inflated by post-COVID pent-up demand, and mid-range model stocking gaps may be costing revenue in peak months.

**Delhi is carrying the business.** At ₹203.9M, Delhi contributes 26.5% of total revenue — double Mumbai at ₹127.2M. Every other city sits between ₹26M and ₹31M. That concentration is both a strength and a risk.

**Mid-range models beat flagships.** iPhone SE at ₹59.6M is the top model, ahead of Galaxy Note 20 and OnePlus Nord. Indian buyers want brand names at accessible prices. The data says stock more iPhone SEs, not more iPhone 15 Pros.

**The 46–60 age group drives a third of all revenue.** ₹249.5M out of ₹769M total. This group is buying premium devices and deserves campaigns built specifically for them — EMI financing, trade-in programs, in-store support events.

---

## The Recommendations

I framed the recommendations around business value, not analytics complexity.

The highest-priority action is understanding the revenue decline — pulling competitor pricing data, interviewing sales staff, and looking at which models lost share between 2022 and 2024. Without that diagnosis, every other intervention is guesswork.

Second is Delhi expansion. The data shows the city is the strongest market by far. More inventory capacity, a dedicated local team, and city-specific marketing would be high-ROI investments.

Third is targeting the 46–60 segment properly. They generate the most revenue per transaction and are likely underserved by generic campaigns aimed at younger buyers.

The full recommendation set with projected revenue impact is in `docs/stakeholder_recommendations.md`.

---

## Business Impact

The combined addressable revenue opportunity from all recommendations is ₹92–100M annually — against a current revenue pace of roughly ₹215–220M. That's a 40–45% potential improvement from targeted, data-backed decisions.

More importantly, the dashboard makes this analysis repeatable. A manager can open it on Monday morning, check whether the current month is tracking ahead or behind, and know which three levers to pull — without asking the analytics team to build a new report.

That's the real value of good BI work: not the one-time insight, but the system that keeps producing insights as the business evolves.

---

*Tools: Power BI · Python (Pandas, Seaborn, Matplotlib) · SQL (CTEs, Window Functions, CASE WHEN) · Excel*  
*Skills: Data Analysis · EDA · KPI Reporting · Sales Analytics · Business Intelligence · Customer Segmentation · Revenue Analysis · Stakeholder Reporting*
