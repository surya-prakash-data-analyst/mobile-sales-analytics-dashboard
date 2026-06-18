# Data Dictionary — Mobile Sales Dataset

**File:** `data/Mobile_Sales_Data.xlsx`  
**Sheet:** Sheet1  
**Records:** 3,835 transactions  
**Period:** October 2021 – October 2024  
**Granularity:** Individual transaction level

---

## Column Reference

| Column | Type | Example Values | Description |
|--------|------|----------------|-------------|
| Transaction ID | Integer | 1, 2, 3 … 3835 | Unique identifier for each sales transaction |
| Day | Integer | 1–31 | Day of month the transaction occurred |
| Month | Integer | 1–12 | Month number (1 = January) |
| Year | Integer | 2021, 2022, 2023, 2024 | Year of transaction |
| Day Name | String | Monday, Tuesday … | Day of week name |
| Brand | String | Apple, Samsung, OnePlus, Vivo, Xiaomi | Mobile device manufacturer |
| Units Sold | Integer | 1–10 | Number of units in this transaction |
| Price Per Unit | Float | ₹10,000–₹80,000 | Selling price per individual unit |
| Customer Name | String | Customer names | Buyer name (masked for privacy in analysis) |
| Customer Age | Integer | 18–70 | Age of the purchasing customer |
| City | String | Delhi, Mumbai, Chennai … | City where the sale occurred |
| Payment Method | String | UPI, Debit Card, Credit Card, Cash | Payment method used |
| Customer Ratings | Integer | 1–5 | Post-purchase satisfaction rating |
| Mobile Model | String | iPhone SE, Galaxy S21 … | Specific model name of device sold |

---

## Derived / Engineered Fields

| Field | Formula | Type | Description |
|-------|---------|------|-------------|
| Revenue | `Units Sold × Price Per Unit` | Float | Transaction-level revenue — the primary KPI metric used throughout all analysis |
| Age_Group | `pd.cut(Customer Age, bins=[0,25,35,45,60,100])` | Categorical | Customer grouped into 5 age bands: 18-25, 26-35, 36-45, 46-60, 60+ |

---

## Key Statistics

| Metric | Value |
|--------|-------|
| Total records | 3,835 |
| Total revenue | ₹769,204,988 |
| Total units sold | 19,150 |
| Avg price per unit | ₹40,114 |
| Avg transaction value | ₹200,575 |
| Avg units per transaction | 4.99 |
| Avg customer rating | 3.69 / 5.0 |
| Date range | Oct 2021 – Oct 2024 |

---

## Brand Coverage

| Brand | Transactions | Revenue | Share |
|-------|-------------|---------|-------|
| Apple | 783 | ₹161.6M | 21.0% |
| Samsung | 775 | ₹160.0M | 20.8% |
| OnePlus | 768 | ₹153.7M | 20.0% |
| Vivo | 766 | ₹150.1M | 19.5% |
| Xiaomi | 743 | ₹143.8M | 18.7% |

---

## City Coverage

| City | Revenue | Share |
|------|---------|-------|
| Delhi | ₹203.9M | 26.5% |
| Mumbai | ₹127.2M | 16.5% |
| Ranchi | ₹31.0M | 4.0% |
| Chennai | ₹30.8M | 4.0% |
| Rajkot | ₹27.3M | 3.5% |
| Jodhpur | ₹27.2M | 3.5% |
| Bangalore | ₹27.0M | 3.5% |
| Lucknow | ₹26.8M | 3.5% |

---

## Payment Method Coverage

| Method | Revenue | Share |
|--------|---------|-------|
| UPI | ₹201.7M | 26.2% |
| Debit Card | ₹195.7M | 25.4% |
| Credit Card | ₹186.7M | 24.3% |
| Cash | ₹185.1M | 24.1% |

---

## Missing Values

No missing values were found in the dataset. All 3,835 records are complete across all 14 columns.

---

## Notes for SQL Users

When loading into a relational database, the recommended table name is `mobile_sales`. The `Revenue` derived column should be computed in queries as `units_sold * price_per_unit` rather than stored as a separate column, to maintain data integrity with the source.
