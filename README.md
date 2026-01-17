# Diagnosing Revenue Decline in an E-commerce Platform

## Business Context
The e-commerce platform has observed a decline in overall revenue over the past few months, despite stable website traffic and increased marketing spend.

This disconnect between traffic and revenue suggests potential issues beyond user acquisition, such as conversion efficiency, pricing strategy, customer behavior, or operational performance.

Senior leadership wants to understand:
- Why revenue is falling  
- Which factors are driving the decline  
- What data-backed actions can reverse the trend  


## Project Objective
The objective of this project is to:
- Diagnose the root causes of revenue decline using data  
- Test structured business hypotheses instead of making assumptions  
- Provide actionable recommendations to improve revenue performance  

This project is approached from a **Business Analyst / Data Analyst perspective**, focusing on **decision-making and business impact rather than only reporting**.


## Key Metrics Considered
Revenue in e-commerce is influenced by multiple levers. This analysis focuses on the following core metrics:

- Revenue  
- Number of Orders  
- Conversion Rate  
- Average Order Value (AOV)  
- Repeat Customer Rate  
- Return Rate  
- Category-wise Revenue Contribution  
- Payment Success Rate  

Each metric is analyzed across relevant dimensions such as **time, customer type, category, and payment method** to identify hidden drivers.


## E-commerce Funnel Considered
Although full traffic data may not always be available, the analysis is framed around a standard e-commerce funnel:

1. Visit  
2. Add to Cart  
3. Checkout  
4. Payment Success  
5. Order Delivered  

Revenue leakage can occur at multiple stages, especially during checkout, payment, and post-purchase (returns).


## Hypothesis-Driven Analysis
Instead of jumping to conclusions, this project follows a **hypothesis-driven approach**. Each hypothesis is validated or rejected using SQL and Python analysis.


### Hypothesis 1: Conversion Rate Decline
Revenue declined because fewer visitors converted into completed orders despite stable traffic.

- **Metric:** Conversion Rate  
- **Dimensions:** Month-over-month, funnel stage (checkout → payment)  
- **Validation Logic:**  
  A significant drop in conversion rate over time would support this hypothesis.


### Hypothesis 2: Average Order Value (AOV) Decrease
Revenue declined due to a reduction in average order value caused by pricing or discounting strategies.

- **Metric:** Average Order Value (AOV)  
- **Dimensions:** Time, customer type (new vs repeat), discount usage  
- **Validation Logic:**  
  If AOV declines primarily in discounted or new-user orders, this hypothesis is supported.


### Hypothesis 3: Decline in Repeat Customer Contribution
Repeat customers, though a smaller share of users, often contribute a disproportionate share of revenue. A decline in repeat purchases could significantly impact overall revenue.

- **Metric:** Repeat order rate, repeat revenue share  
- **Dimensions:** Month, customer type  
- **Validation Logic:**  
  A noticeable drop in repeat revenue contribution would confirm this hypothesis.


### Hypothesis 4: Increase in Product Returns
Net revenue declined due to an increase in product returns, potentially driven by quality issues, category-specific problems, or aggressive discounting.

- **Metric:** Return Rate  
- **Dimensions:** Category, time, discount flag  
- **Validation Logic:**  
  A sharp rise in return rates in specific categories would support this hypothesis.


### Hypothesis 5: Category Mix Shift Toward Low-Value Products
Revenue declined because customer purchasing behavior shifted toward lower-priced or lower-margin categories.

- **Metric:** Revenue contribution by category  
- **Dimensions:** Category, month  
- **Validation Logic:**  
  If high-value categories lose revenue share while low-value categories gain share, this hypothesis is validated.


### Hypothesis 6: Checkout or Payment Failures
Revenue declined due to increased checkout drop-offs or payment failures, especially across specific payment methods.

- **Metric:** Payment Success Rate  
- **Dimensions:** Payment method, time  
- **Validation Logic:**  
  An increase in payment failures over time would confirm this hypothesis.


## Analytical Approach
The analysis was approached in the same way a real-world business problem is handled.

The work began with high-level revenue and order trends to confirm that traffic was not the primary issue. From there, the focus shifted to identifying potential revenue leakage across conversion, pricing, customer behavior, and post-purchase stages.

Each potential cause was framed as a testable hypothesis and validated using targeted SQL and Python analysis. Rather than analyzing all metrics simultaneously, the approach focused on isolating one driver at a time and validating it with data before moving forward.

Insights were then translated into clear business implications and recommendations rather than only visual outputs.


## Tools and Technologies
- **SQL (PostgreSQL):** Data extraction, joins, window functions, hypothesis testing  
- **Python (Pandas, Matplotlib):** Exploratory analysis and cohort analysis  
- **Power BI:** Stakeholder-friendly dashboards  
- **GitHub:** Version control and documentation  


## Expected Outcome
By the end of this project, the analysis aims to:
- Identify the primary drivers of revenue decline  
- Quantify the impact of each driver  
- Recommend targeted, data-backed actions such as:
  - Improving checkout and payment success  
  - Optimizing discount strategy  
  - Re-engaging repeat customers  
  - Fixing high-return categories  


## Why This Project Matters
This project demonstrates:
- Structured problem-solving under ambiguity  
- Strong business and analytical thinking  
- Ability to translate data into decisions  
