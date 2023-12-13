{% macro iso8601_fields(model_name) %}
  select
    to_char({{ ref(model_name) }}.created_at, 'YYYY-MM-DD"T"HH24:MI:SS"Z"') as created_at_iso8601,
    to_char({{ ref(model_name) }}._fivetran_synced, 'YYYY-MM-DD"T"HH24:MI:SS"Z"') as updated_at_iso8601
  from {{ ref(model_name) }}
{% endmacro %}

