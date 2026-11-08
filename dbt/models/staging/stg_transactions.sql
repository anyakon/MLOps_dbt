select
    cast(transaction_time as DateTime) as transaction_time,
    cast(merch as String) as merch,
    cast(cat_id as String) as cat_id,
    cast(amount as Float64) as amount,
    cast(name_1 as String) as name_1,
    cast(name_2 as String) as name_2,
    cast(gender as String) as gender,
    cast(us_state as String) as us_state,
    cast(lat as Float64) as lat,
    cast(lon as Float64) as lon,
    cast(merchant_lat as Float64) as merchant_lat,
    cast(merchant_lon as Float64) as merchant_lon,
    cast(target as UInt8) as target,
    concat(name_1, '|', name_2) as customer_id,
    {{ amount_bucket('amount') }} as amount_bucket,
    toDate(transaction_time) as tx_date
from {{ source('transactions_db', 'transactions') }}
where toDate(transaction_time) <= {{ dbt_date.today() }}
