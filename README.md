# Diagnosing Revenue Decline in an E-commerce Platform
## Key Finding
Revenue decline was **not caused by falling demand, pricing issues, or payment failures**.

Instead, **25.1% of all paid revenue (₹1,23,218)** never converted into realized revenue because of post-payment fulfillment failures:

- **Product Returns:** ₹70,959 (57.6% of leakage)
- **Stuck Orders:** ₹52,259 (42.4% of leakage)

The biggest opportunity is improving fulfillment efficiency and reducing return-related leakage.

# Executive Summary

The platform collected **₹4,91,863** in payments during the analysis period, but only **₹3,68,645** became realized revenue.

That means:

- **₹1,23,218 leaked**
- Nearly **1 in every 4 rupees paid was lost**
- Leakage happened **after payment**, not before it

A structured funnel analysis ruled out:

- Demand-side decline
- AOV deterioration
- Pricing problems
- Payment infrastructure instability

The root cause is operational:

 Customers are successfully paying, but orders are either getting returned or never reaching successful fulfillment.

# Business Context

The e-commerce platform experienced a steady revenue decline over an **8-month period (Feb–Sep 2024)** despite:

- Stable website traffic
- Consistent marketing spend

Leadership wanted to understand:

- Why revenue was declining
- Which operational drivers were responsible
- What measurable actions could reverse the trend

This project approaches the problem from a **Business Analyst / Data Analyst perspective**, focusing on:

- Hypothesis-driven investigation
- Revenue impact quantification
- Actionable business recommendations

# Key Metrics Analyzed

| Metric | Value | Insight |
|---|---|---|
| Total Paid Revenue | ₹4,91,863 | Baseline |
| Realized Revenue | ₹3,68,645 | Only 75% realized |
| Revenue Leakage | ₹1,23,218 | 25.1% leakage |
| Return Rate | 12.2% overall | Electronics highest at 14.5% |
| Payment Failure Rate | 10.2% | Secondary issue |
| Discounted Order Return Rate | 17.0% | vs 10.4% non-discounted |

# E-commerce Funnel Analysis

```text
Visit → Add to Cart → Checkout → Payment Success → Delivered
                                      ↓                 ↓
                               10.2% fail         25.1% leak
                                (₹52,171)         (₹1,23,218)
```

## Critical Insight

Revenue leakage is concentrated **after payment**:

- Orders are successfully placed
- Customers are paying
- But fulfillment breaks down afterward

This confirms the issue is operational, not acquisition-related.

# Hypothesis-Driven Analysis

## Hypothesis 1: Conversion Rate Decline

### Verdict: Not the primary driver

- Order volume remained stable
- No major checkout drop-offs observed
- Paying customer acquisition remained healthy

### Conclusion

The platform is still generating paying customers — the issue is retaining revenue after payment.

## Hypothesis 2: Average Order Value (AOV) Decrease

### Verdict: Not supported

- AOV ranged between **₹2,278–₹3,282**
- No sustained downward trend observed

### Conclusion

Customers were not spending less.

Revenue fluctuations were driven by leakage, not basket size.

## Hypothesis 3: Decline in Repeat Customer Contribution

### Verdict: Contributing factor, not root cause

A small subset of customers contributed disproportionately:

- User 63 → 5 orders
- User 29 → 4 orders

### Insight

High-frequency buyer churn could disproportionately impact revenue.

However, this is still secondary compared to fulfillment leakage.

## Hypothesis 4: Increase in Product Returns

### Verdict: PRIMARY DRIVER

Returns accounted for:

- **₹70,959 lost revenue**
- **57.6% of total leakage**

## Return Leakage by Category

| Category | Return Rate | Revenue Lost | Share of Return Leakage |
|---|---|---|---|
| Electronics | 14.5% | ₹27,015 | 38.1% |
| Fashion | 11.3% | ₹20,451 | 28.8% |
| Beauty | 11.9% | ₹14,060 | 19.8% |
| Home | 11.8% | ₹9,433 | 13.3% |

### Key Insight

Electronics + Fashion together contributed:

- **66.9% of return-related revenue loss**

## Discount Compounding Effect

| Order Type | Return Rate |
|---|---|
| Discounted Orders | 17.0% |
| Non-Discounted Orders | 10.4% |

Discounted orders had a **63% higher return rate**, indicating that aggressive discounting is increasing low-quality purchases and return volume.

## Hypothesis 5: Category Mix Shift Toward Low-Value Products

### Verdict: Partially supported

No major category shift occurred.

However:

- Electronics had both:
  - Highest AOV
  - Highest return rate

This created a compounding effect where high-value failed orders disproportionately damaged realized revenue.

## Hypothesis 6: Checkout or Payment Failures

### Verdict: Secondary contributor

- 21 failed payment orders
- ₹52,171 lost before entering fulfillment

### Important Observation

Failures were not concentrated in one payment method.

This suggests:

- Systemic checkout reliability issues
- Possible UX friction during payment completion

Not a gateway-specific problem.

# Monthly Trend Insight

Revenue leakage persisted across all 8 months.

This confirms the problem is:

- Structural
- Operational
- Recurring

Not a temporary spike.

August generated the highest paid revenue (**₹70,110**) but still suffered heavy leakage, proving that increasing order volume alone will not solve profitability problems without operational fixes.

# Actionable Recommendations

## 1. Reduce Electronics Return Rate (Highest ROI)

### Problem

- Electronics return rate: **14.5%**
- Revenue leakage: **₹27,015**

Largest contributor to overall losses.

### Recommended Actions

- Add detailed specification sheets
- Improve compatibility guidance
- Add verified buyer Q&A
- Introduce pre-dispatch quality checks for high-value orders (>₹3,000)

### Expected Impact

Reducing return rate from:

14.5% → 10.5%

could recover approximately:

- **₹7,400/month**

## 2. Restructure Discount Strategy

### Problem

Discounts are subsidizing purchases that later get returned.

### Recommended Actions

- Replace blanket discounts with category-specific offers
- Restrict discounts to low-return categories
- Introduce “discount lock” policies for repeat returners

### Expected Impact

Matching discounted-order return rate to non-discounted levels could prevent:

- **₹9,800/year in leakage**

## 3. Resolve Stuck Orders

### Problem

- 22 stuck orders
- ₹52,259 trapped in fulfillment limbo

### Recommended Actions

- SLA alert if order not shipped within 48 hours
- Proactive customer communication after 72 hours
- Investigate warehouse/category clustering

### Expected Impact

- Immediate recovery: **₹52,259**
- Long-term realized revenue improvement toward **85%+**

## 4. Reduce Payment Failure Rate

### Problem

- Payment failure rate: **10.2%**
- Industry benchmark: **3–5%**

### Recommended Actions

- Introduce payment retry flows
- Offer alternate payment method suggestions
- Audit checkout UX friction points

### Expected Impact

- 15% payment recovery could recover:
  - **₹7,826**
- Reaching industry benchmark could add:
  - **₹26,000+ annually**

# Combined Recovery Potential

| Action | Estimated Recovery |
|---|---|
| Reduce Electronics Return Rate | ₹7,400/month |
| Fix Discount-Driven Returns | ₹9,800/year |
| Resolve Stuck Orders | ₹52,259 + structural gains |
| Payment Retry Flow | ₹7,826/cycle |
| Total Addressable Leakage | ₹1,23,218 |

# Tools & Technologies

- **SQL (PostgreSQL)** → Data extraction, CTEs, hypothesis testing
- **Python (Pandas, Matplotlib)** → EDA & visualization
- **Power BI** → Stakeholder dashboarding
- **GitHub** → Documentation & version control

# Why This Project Matters

This project demonstrates:

- Structured hypothesis-driven business analysis
- Revenue-focused decision-making
- Ability to quantify business impact in ₹ terms
- Executive-level communication
- End-to-end ownership from raw data to recommendations

It focuses not just on identifying problems — but on prioritizing the highest-leverage business actions to recover revenue efficiently.
