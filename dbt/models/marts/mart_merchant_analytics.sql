with merchants as (
    select
        merch,
        count() as tx_count,
        sum(amount) as turnover,
        sum(target) as fraud_count,
        round({{ dbt_utils.safe_divide('sum(target) * 100', 'count()') }}, 2) as fraud_rate
    from {{ ref('stg_transactions') }}
    group by merch
)

select
    merch,
    tx_count,
    turnover,
    fraud_count,
    fraud_rate,
    toUInt8(fraud_rate >= 1) as is_suspicious
from merchants
