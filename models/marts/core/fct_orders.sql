


with 

    orders as (

    select
        id_order,
        id_promo,
        promo_description,
        decode(shipping_service,'', 'Non assigned', shipping_service ) as shipping_service,
        shipping_cost_USD,
        id_address,
        created_at,
        estimated_delivery_at,
        delivered_at,
        delivered_at - estimated_delivery_at as time_to_deliver,
        id_tracking,
        status,
        order_cost_USD,
        order_total_USD,
        id_user,
        _fivetran_deleted,
        _fivetran_synced 
        
    from {{ ref('stg_orders') }} 
    
)

select * from orders 

