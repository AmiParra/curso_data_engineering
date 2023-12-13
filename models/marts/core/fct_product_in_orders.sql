

WITH orders AS (
    select * from {{ ref('stg_orders') }}
),

order_items AS (
    select * from {{ ref('stg_order_items') }}
),

products AS (
    select * from {{ ref('dim_products') }} 
),

comb_order_product_details AS (
    SELECT
        o.id_order,
        o.id_promo,
        o.id_user,
        o.promo_description,
        o.shipping_cost_USD,
        o.created_at,
        o.order_cost_USD,
        o.order_total_USD,
        oi.quantity,
        p.product_name,
        p.business,
        p.price_USD,
        o._fivetran_synced 
    FROM orders o
    LEFT JOIN order_items oi ON o.id_order = oi.id_order
    LEFT JOIN products p ON p.id_product = oi.id_product
)


select * from comb_order_product_details
order by id_order



