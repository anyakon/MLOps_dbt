with customers as (
    select
        customer_id,
        any(name_1) as name_1,
        any(name_2) as name_2,
        count() as tx_count,
        sum(target) as fraud_count,
        round({{ dbt_utils.safe_divide('sum(target) * 100', 'count()') }}, 2) as fraud_rate,
        avg(amount) as avg_check,
        min(transaction_time) as first_tx,
        max(transaction_time) as last_tx
    from {{ ref('stg_transactions') }}
    group by customer_id
)

select
    customer_id,
    name_1,
    name_2,
    tx_count,
    fraud_count,
    fraud_rate,
    avg_check,
    first_tx,
    last_tx,
    case
        when fraud_rate >= 5 or fraud_count >= 3 then 'HIGH'
        when fraud_count >= 1 then 'MEDIUM'
        else 'LOW'
    end as risk_segment
from customers
