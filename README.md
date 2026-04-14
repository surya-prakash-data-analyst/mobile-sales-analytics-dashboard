# 📱 Mobile Sales Analytics Dashboard — Revenue Trends & Market Performance Intelligence

> **Decoding ₹76.9 Cr of mobile market data into actionable business strategy** | Power BI · Python · EDA · Sales Analytics

---

![Python](https://img.shields.io/badge/Python-3.9+-3776AB?logo=python&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?logo=powerbi&logoColor=black)
![Pandas](https://img.shields.io/badge/Pandas-EDA-150458?logo=pandas&logoColor=white)
![Records](https://img.shields.io/badge/Records-3%2C835_Transactions-brightgreen)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

---

## 🏷️ Keywords
`Sales Analytics` · `Power BI Dashboard` · `Revenue Analysis` · `Exploratory Data Analysis` · `KPI Tracking` · `Data Visualization` · `Market Intelligence` · `Trend Analysis` · `Business Insights` · `Data Cleaning & Transformation`

---

## 📌 Business Problem

The mobile phone market moves fast. New models launch every quarter, consumer preferences shift with each product cycle, and sales teams are often the last to know when a trend has already peaked. Without real-time visibility into *what's selling, where, and to whom* — inventory, pricing, and promotional decisions get made on instinct rather than evidence.

This project transforms raw transactional data from **3,835 sales records across 19 Indian cities (2021–2024)** into a decision-ready analytics dashboard that any business leader can navigate and act on.

---

## 🎯 Objective

Design and deliver a mobile sales analytics solution that tracks revenue KPIs, surfaces brand and model performance trends, identifies geographic demand patterns, and enables smarter stock, pricing, and campaign decisions — backed by 3+ years of real transaction data.

---

## 📊 Dataset Description

| Property | Details |
|---|---|
| **File** | `Mobile_Sales_Data.xlsx` |
| **Records** | 3,835 transactions |
| **Period** | October 2021 — October 2024 (3+ years) |
| **Features** | 14 columns — Brand, Units Sold, Price Per Unit, City, Payment Method, Customer Age, Customer Ratings, Mobile Model |
| **Brands** | Apple · Samsung · OnePlus · Vivo · Xiaomi |
| **Cities** | 19 cities including Delhi, Mumbai, Chennai, Bangalore, Lucknow |
| **Derived Feature** | Revenue = Units Sold × Price Per Unit |

---

## 🛠 Tools & Technologies

| Layer | Stack |
|---|---|
| **Dashboard & Reporting** | Power BI — DAX measures, KPI cards, slicers, drill-throughs |
| **Exploratory Data Analysis** | Python — Pandas, NumPy |
| **Data Visualization** | Matplotlib, Seaborn |
| **Data Cleaning & Transformation** | Revenue derivation, date parsing, age group binning |
| **Report Generation** | ReportLab (PDF) |
| **Version Control** | Git & GitHub |

---

## 🔍 Analysis Approach

1. **Data Ingestion & Cleaning** — Validated 14 columns for nulls and type issues. Derived Revenue column. Parsed date fields for time-series analysis.
2. **Brand & Model Analysis** — Compared all 5 brands on revenue, units sold, and transaction volume. Ranked top mobile models by revenue contribution.
3. **Geographic Intelligence** — Mapped city-level revenue across 19 cities to identify concentration risk and growth markets.
4. **Time-Series Trend Analysis** — Plotted monthly revenue across 36+ months to identify seasonality and demand peaks.
5. **Power BI Dashboard Development** — Designed an interactive dashboard with brand/city filters and revenue KPI tracking.

---

## 📈 Key Insights

- 💰 **Total revenue: ₹76.9 Crore** across 3,835 transactions and 19,150 units sold over 3 years.
- 🏙️ **Delhi alone contributes ₹20.4Cr (26.5%)** — followed by Mumbai at ₹12.7Cr. Two cities driving 43% of revenue = high concentration risk.
- 📱 **iPhone SE leads all models at ₹5.96Cr** — proving mid-range value positioning beats premium flagships in volume markets.
- ⚖️ **All 5 brands hold ~20% unit market share** — a highly competitive, undifferentiated market where ASP and model mix drive revenue differences.
- 💳 **UPI leads payment methods at 26.4%** — digital payment adoption is well underway; cash still at 24.2% in smaller cities.
- ⭐ **60.8% customers rated 4–5 stars** (avg: 3.69/5) — healthy satisfaction, but 22.3% low-rating segment needs brand/city-level investigation.
- 📅 **March–May and July are consistent revenue peaks** — predictable seasonality enables proactive inventory planning.
- 🏘️ **Tier-2 cities (Ranchi, Rajkot, Jodhpur) each generating ₹2.7Cr+** — parity with Bangalore signals serious untapped growth potential.

---

## 📊 Dashboard & Visualizations

### KPI Summary
![KPI Summary](images/kpi_summary.png)

### Brand Revenue Performance
![Brand Revenue](images/brand_revenue.png)

### Monthly Revenue Trend
![Monthly Trend](images/monthly_trend.png)

### City-wise Sales
![City Sales](images/city_sales.png)

### Payment Method Distribution
![Payment Methods](images/payment_method.png)

### Top Mobile Models
![Top Models](images/top_models.png)

### Customer Ratings Distribution
![Customer Ratings](images/customer_ratings.png)

### Yearly Revenue Growth
![Yearly Revenue](images/yearly_revenue.png)

---

## 💡 Business Recommendations

1. **Reduce Delhi–Mumbai concentration risk** — Invest in Tier-2 cities. Ranchi, Rajkot, and Jodhpur are already generating ₹2.7Cr+ each with likely lower customer acquisition cost.
2. **Double down on mid-range models** — iPhone SE (₹5.96Cr) and OnePlus Nord (₹5.79Cr) outperform premium flagships. Prioritize mid-range inventory depth.
3. **Build UPI-first loyalty programs** — 26.4% digital payment adoption is growing. UPI cashback or points programs can improve retention and purchase frequency.
4. **Investigate the 22.3% low-rating segment by city and brand** — Segment 1–2 star ratings to isolate service, product, or delivery gaps before they compound.
5. **Pre-load inventory for March–May and July peaks** — Stock up 3–4 weeks early for high-demand models to prevent lost sales during seasonal stock-out windows.

---

## 📂 Project Structure

```
mobile-sales-analytics-dashboard/
│
├── 📁 dashboard/
│   └── sales_data.pbix                    # Interactive Power BI dashboard
│
├── 📁 data/
│   └── Mobile_Sales_Data.xlsx             # Source dataset (3,835 × 14)
│
├── 📁 notebooks/
│   └── Mobile_Sales_EDA.ipynb             # Full exploratory analysis
│
├── 📁 scripts/
│   └── generate_visuals.py                # Chart generation script
│
├── 📁 images/                             # All chart PNGs for README
│   ├── kpi_summary.png
│   ├── brand_revenue.png
│   ├── monthly_trend.png
│   ├── city_sales.png
│   ├── payment_method.png
│   ├── top_models.png
│   ├── customer_ratings.png
│   └── yearly_revenue.png
│
├── 📁 docs/
│   └── Mobile_Sales_Insights_Report.pdf
│
├── requirements.txt
└── README.md
```

---

## 🚀 How to Run

```bash
git clone https://github.com/surya-prakash-data-analyst/mobile-sales-analytics-dashboard.git
cd mobile-sales-analytics-dashboard
pip install -r requirements.txt
jupyter notebook notebooks/Mobile_Sales_EDA.ipynb
```

---

## 📬 Contact

**Surya Prakash** — Data Analyst  
📍 Hyderabad, India  
🔗 [LinkedIn](https://www.linkedin.com/in/surya-prakash-data-analyst) · 🐙 [GitHub](https://github.com/surya-prakash-data-analyst)

---

> *"Sales data is just noise until you know what questions to ask. This dashboard was built to ask the right ones — automatically, every time."*

---
*Built with real data · 3,835 transactions · 19 cities · 3 years · Insights verified · Recommendations actionable.*
