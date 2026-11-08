select
    t.us_state,
    s.state_name,
    count() as tx_count,
    sum(t.target) as fraud_count,
    round({{ dbt_utils.safe_divide('sum(t.target) * 100', 'count()') }}, 2) as fraud_rate,
    uniqExact(t.customer_id) as customer_count,
    uniqExact(t.merch) as merchant_count,
    sum(t.amount) as amount_sum,
    sumIf(t.amount, t.target = 1) as fraud_amount
from {{ ref('stg_transactions') }} as t
left join {{ ref('states') }} as s
    on t.us_state = s.state_code
group by t.us_state, s.state_name
