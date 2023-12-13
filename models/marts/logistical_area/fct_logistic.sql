
  with 
    dim_shipping as (select * from {{ ref('dim_shipping_service') }}),
     
    int_orders_delivery as (select * from {{ ref('int_orders_delivery_info') }}) ,

     fct_logistic as (
    select
        d.id_shipping_service,
        i.id_order,
        i.shipping_service,
        i.status,
        i.created_at,
        i.estimated_delivery_at,
        i.delivered_at,
        time_to_deliver,
        delivery_info,
        earlier_days,
        delay_days
 

        from int_orders_delivery i
        left join dim_shipping d on i.id_shipping_service = d.id_shipping_service
)

select * from fct_logistic





