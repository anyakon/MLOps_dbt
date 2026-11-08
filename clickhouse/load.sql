TRUNCATE TABLE transactions_db.transactions;

INSERT INTO transactions_db.transactions
SELECT
    parseDateTimeBestEffort(transaction_time) AS transaction_time,
    merch,
    cat_id,
    toFloat64(amount) AS amount,
    name_1,
    name_2,
    gender,
    street,
    one_city,
    us_state,
    post_code,
    toFloat64(lat) AS lat,
    toFloat64(lon) AS lon,
    toUInt32(population_city) AS population_city,
    jobs,
    toFloat64(merchant_lat) AS merchant_lat,
    toFloat64(merchant_lon) AS merchant_lon,
    toUInt8(target) AS target
FROM file(
    'train.csv',
    'CSVWithNames',
    'transaction_time String, merch String, cat_id String, amount String, name_1 String, name_2 String, gender String, street String, one_city String, us_state String, post_code String, lat String, lon String, population_city String, jobs String, merchant_lat String, merchant_lon String, target String'
);
