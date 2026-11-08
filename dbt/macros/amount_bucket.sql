{% macro amount_bucket(amount_column) %}
case
    when {{ amount_column }} < 10 then 'small'
    when {{ amount_column }} < 100 then 'medium'
    when {{ amount_column }} < 500 then 'large'
    else 'xlarge'
end
{% endmacro %}
