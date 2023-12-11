



with 
    dim_shipping as (select * from {{ ref('dim_shipping_service') }}),
     
    int_orders_delivery as (select * from {{ ref('int_orders_delivery_info') }}) ,


fct_logistic as (
    select
        d.id_delivery_info,
        i.id_delivery_info,
        i.id_order,
        i.shipping_service,
        i.shipping_cost_USD,
        i.order_cost_USD,
        i.id_tracking,
        i.status,
        i.created_at,
        i.estimated_delivery_at,
        i.delivered_at,
        d.time_to_deliver,
        d.earlier_days,
        d.delay_days

        from int_orders_delivery_info i
        left join dim_shipping_service d on i.id_delivery_info = d.id_delivery_info
)


select * from fct_logistic