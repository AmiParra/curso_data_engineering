with 
orders_delivery_info as (
    select * from {{ ref('int_orders_delivery_info') }}
),

d_shipping_service as(
    select
        distinct decode(shipping_service,'', 'Non assigned', shipping_service ) as shipping_service

    from orders_delivery_info

),

dim_shipping_service as (
    select

        decode(shipping_service,'Non assigned', {{ dbt_utils.generate_surrogate_key(['9999']) }} ,{{ dbt_utils.generate_surrogate_key(['shipping_service']) }}) as id_shipping_service,
        shipping_service
        
    from d_shipping_service
)

select * from dim_shipping_service

