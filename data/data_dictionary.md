### users.csv
| Column Name | Description |
|------------|------------|
| user_id | Unique identifier for each user |
| signup_date | Date the user registered |
| user_type | New or repeat customer |

### orders.csv
| Column Name | Description |
|------------|------------|
| order_id | Unique order identifier |
| user_id | User who placed the order |
| order_date | Date order was placed |
| order_value | Monetary value of the order |
| payment_status | success / failed |
| order_status | placed / delivered / returned / cancelled |
