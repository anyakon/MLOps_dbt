```powershell
pip install -r requirements.txt
docker compose up -d --wait
docker compose cp "data/train.csv" clickhouse:/var/lib/clickhouse/user_files/train.csv
docker compose exec -T clickhouse clickhouse-client --password hw4 --queries-file /sql/load.sql

cd dbt
dbt deps --profiles-dir .
dbt seed --profiles-dir .
dbt run --profiles-dir .
dbt test --profiles-dir .
dbt docs generate --profiles-dir .
```
