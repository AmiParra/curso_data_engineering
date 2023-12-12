
-- modelo dbt en /models/orders.sql
WITH formatted_dates AS (

  {{ iso8601_fields('stg_orders') }}

)

SELECT
  -- Selecciona las columnas transformadas en la CTE aquí
  fd.created_at_iso8601,
  fd.updated_at_iso8601,
  -- Añade las demás columnas que necesitas del modelo
  o.*
FROM formatted_dates fd
JOIN {{ ref('stg_orders') }} o
  ON fd.created_at_iso8601 = o.created_at
  -- Ajusta esta condición de JOIN para que coincida con tu lógica de negocio


