.PHONY: deps seed run test docs check

deps:
	dbt deps --profiles-dir .

seed:
	dbt seed --profiles-dir .

run:
	dbt run --profiles-dir .

test:
	dbt test --profiles-dir .

docs:
	dbt docs generate --profiles-dir .

check: deps seed run test docs
