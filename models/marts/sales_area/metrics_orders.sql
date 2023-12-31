

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
        --o.id_promo,
        o.promo_description,
        --o.shipping_service,
        o.shipping_cost_USD,
        --o.id_address,
        o.created_at,
        --o.estimated_delivery_at,
        o.order_cost_USD,
        --o.id_user,
        o.order_total_USD,
        --o.delivered_at,
        --o.id_tracking,
        --o.status,
        --oi.id_order_items,
        --oi.id_product,
        oi.quantity,
        p.product_name,
        p.business,
        p.price_USD,
        o._fivetran_synced 
    FROM orders o
    LEFT JOIN order_items oi ON o.id_order = oi.id_order
    LEFT JOIN products p ON p.id_product = oi.id_product
)

-- Tener en cuenta que aquí se están calculando la media de unidades de producto vendidas en cada orden y la media del coste total de la orden.
-- Hay que tener en cuenta está lógica para los posibles análisis, por ejemplo: relación entre la cantidad de dicho producto y si está 
-- asociado con orders de mayor coste. 

SELECT product_name, avg(quantity) as avg_product_units , avg(order_cost_USD) as avg_order_usd FROM comb_order_product_details
group by product_name
order by avg_product_units desc
--select * from comb_order_product_details
--order by id_order

