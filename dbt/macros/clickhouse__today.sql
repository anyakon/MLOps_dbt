{% macro clickhouse__today(tz=None) %}
    toDate(now())
{% endmacro %}
