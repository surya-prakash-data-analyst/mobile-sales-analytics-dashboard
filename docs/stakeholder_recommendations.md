# Stakeholder Recommendations

## For Sales Leadership

**The most urgent issue is the revenue decline.** Revenue was ₹262M in 2022, ₹253M in 2023, and is trending toward roughly ₹215–225M annualized in 2024. That's a ₹37–47M gap from peak in just two years.

Before making any strategic moves, the team needs to understand *why* this is happening. Three hypotheses worth testing:

1. **Competitive displacement** — Has a new online or physical competitor entered key markets (particularly Delhi) and taken share on specific brand/model combinations?
2. **Product mix shift** — Are customers shifting toward models or price bands that aren't well-stocked? The dominance of mid-range models (iPhone SE #1, OnePlus Nord #2) suggests premium demand may be shifting down.
3. **Customer retention** — Are existing customers returning for upgrades? The data doesn't include a loyalty identifier, but adding one to future records would clarify this.

**Immediate actions:**
- Pull 2024 competitor pricing data for top 5 models
- Interview 10 sales staff across Delhi and Mumbai on what customer objections look like
- Compare 2022 vs 2024 model mix — are the same models selling, or has the mix shifted?

---

## For Marketing

**Target the 46–60 age segment first.** This group contributes ₹249.5M — 32.4% of all revenue — despite likely being a smaller demographic than 26–35 or 36–45. They are buying more premium devices at higher price points.

Campaigns that will resonate with this segment:
- EMI and zero-interest financing on devices over ₹40,000
- Trade-in offers for older devices — this segment has upgrade potential
- In-store service events (screen protection, data transfer, setup support) — older buyers value hands-on assistance over digital-first onboarding

**For the 18–25 segment**, mid-range models are the entry point. iPhone SE and OnePlus Nord are already top performers. A student discount or student financing program could increase volume in this segment without cannibalizing the 46–60 premium buyer.

**On payment method:** All four methods contribute nearly equal revenue (26.2% to 24.1%). Don't deprioritize any payment rail — the customer base is genuinely split. UPI's slight lead reflects India's broader digital payment trend; make sure the UPI checkout experience is fast and error-free.

---

## For Inventory and Operations

**Stock mid-range models more aggressively.** The top 5 models by revenue are all in the ₹25,000–₹55,000 price band — none are ultra-premium flagship models. Specifically:
- iPhone SE — ₹59.6M, ensure stock in Delhi and Mumbai
- OnePlus Nord — ₹57.9M, strong performer across cities
- Galaxy Note 20 — ₹56.0M, Samsung's best performer in this portfolio

**Address Delhi capacity.** Delhi at ₹203.9M is doing 2x Mumbai's volume. If there are any inventory, logistics, or staffing constraints in Delhi, they are costing more revenue than the same constraint anywhere else.

**Expand tier-2 city presence.** Ranchi, Chennai, Rajkot, Jodhpur, Bangalore, and Lucknow each sit at ₹26–31M. These cities have similar revenue to each other, suggesting a pattern — not random variation. A dedicated tier-2 city sales strategy with consistent stocking and local marketing could realistically move any of these cities from ₹30M to ₹40–50M annually.

---

## For Customer Experience

**The 38.8% low-rating problem needs investigation.** Nearly two in five customers gave ratings of 1–3 stars. This is higher than acceptable for a retail operation that depends on repeat purchases and referrals.

Recommended approach:
- Send a structured follow-up survey to recent low-rating customers asking specifically about the purchase experience vs product satisfaction vs after-sales support
- Review whether the low ratings correlate with specific cities, brands, or payment methods — the SQL queries in `customer_segmentation.sql` can surface this
- Implement a 30-day post-purchase check-in for all transactions above ₹40,000

Improving the satisfaction rate from 61.1% (4–5 stars) to 75%+ would meaningfully improve repeat purchase rates and referral volume.
