select
    tx_date,
    us_state,
    count() as tx_count,
    sum(amount) as amount_sum,
    avg(amount) as avg_check,
    arrayReduce('quantile(0.95)', groupArray(amount)) as amount_p95,
    round(
        {{ dbt_utils.safe_divide("countIf(amount_bucket in ('large', 'xlarge')) * 100", "count()") }},
        2
    ) as large_tx_share
from {{ ref('stg_transactions') }}
group by tx_date, us_state
