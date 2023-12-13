
with users as (
    select * from {{ ref('dim_users') }}),

orders as (
    select * from {{ ref('fct_product_in_orders') }}),

promos as (
    select * from {{ref('dim_promos')}}),

    info_orders AS (
    SELECT
        u.id_user,
        u.first_name,
        u.last_name,
        u.phone_number,
        u.email,
        u.address,
        u.zipcode,
        u.city,
        u.country,
        u.state,
        COUNT(DISTINCT o.id_order) AS numb_of_total_orders,
        SUM(o.quantity) AS numb_of_total_products,
        SUM(o.order_cost_USD) AS total_order_cost,
        SUM(o.shipping_cost_USD) AS total_shipping_cost,
        SUM(p.discount_USD) AS total_discount
    FROM
        users u
    LEFT JOIN
        orders o ON u.id_user = o.id_user
    LEFT JOIN
        promos p ON o.id_promo = p.id_promo
    {{dbt_utils.group_by(10)}}
)
SELECT
    *
FROM
    info_orders
ORDER BY
    id_user DESC  -- Ordenar por el total de productos comprados de manera descendente
LIMIT
    10  -- Obtener los 10 usuarios que más compran
