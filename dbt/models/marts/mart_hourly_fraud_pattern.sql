with slots as (
    select
        toDayOfWeek(transaction_time) as day_of_week,
        toHour(transaction_time) as tx_hour,
        count() as tx_count,
        sum(target) as fraud_count,
        round({{ dbt_utils.safe_divide('sum(target) * 100', 'count()') }}, 2) as fraud_rate
    from {{ ref('stg_transactions') }}
    group by day_of_week, tx_hour
),

overall as (
    select
        round({{ dbt_utils.safe_divide('sum(target) * 100', 'count()') }}, 2) as overall_fraud_rate
    from {{ ref('stg_transactions') }}
)

select
    slots.day_of_week,
    slots.tx_hour,
    slots.tx_count,
    slots.fraud_count,
    slots.fraud_rate,
    toUInt8(slots.fraud_rate > overall.overall_fraud_rate) as high_risk_window
from slots
cross join overall
