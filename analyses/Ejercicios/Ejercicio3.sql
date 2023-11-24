{{
    config(
        materialized = 'ephemeral'
    )
}}
WITH stg_orders AS (
    SELECT *
    FROM {{ ref('stg_orders') }}
),

compras_users AS (
    SELECT
        user_id,
        count(distinct order_id) as num_compras
    FROM stg_orders
    GROUP BY 1
    ),

user_por_compra AS(
    SELECT
        CASE
        WHEN num_compras >= 3 THEN '3+'
        ELSE num_compras::VARCHAR
        END AS num_compras,
        count(user_id) as num_users
    FROM compras_users
    GROUP BY 1
)

SELECT * FROM user_por_compra


--select * from stg_orders