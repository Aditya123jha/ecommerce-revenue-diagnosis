## Data Assumptions

- Payment success indicates successful transaction authorization.
- Revenue is realized only for orders with payment_status = 'success' and order_status = 'delivered'.
- Returned and cancelled orders are treated as revenue leakage.
- Traffic data is assumed to be stable as per business context.
