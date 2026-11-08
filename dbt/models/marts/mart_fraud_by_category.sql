select
    cat_id,
    count() as tx_count,
    sum(target) as fraud_count,
    round({{ dbt_utils.safe_divide('sum(target) * 100', 'count()') }}, 2) as fraud_rate,
    sum(amount) as amount_sum,
    sumIf(amount, target = 1) as fraud_amount
from {{ ref('stg_transactions') }}
group by cat_id
