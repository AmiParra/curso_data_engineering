

with 
    order_delivery as (
        select 

            id_order,
            shipping_service,
            shipping_cost_USD,
            id_address,
            order_cost_USD,
            order_total_USD,
            id_tracking,
            status,
            created_at,
            estimated_delivery_at,
            delivered_at,
            delivered_at - estimated_delivery_at as time_to_deliver,
            case 
                when time_to_deliver is null then 'In progress'
                when time_to_deliver = 0 then 'On time'
                when time_to_deliver > 0 then 'With delay'
                else 'Earlier as expected'
            end as delivery_info,
            case
                when time_to_deliver < 0 then abs(time_to_deliver)
                else null
            end as earlier_days,
            case 
                when time_to_deliver > 0 then time_to_deliver
                else null
            end as delay_days,
            _fivetran_deleted,
            _fivetran_synced
    
        from {{ ref('stg_orders') }}


),


    order_delivery_info as (
        select
             {{ dbt_utils.generate_surrogate_key(['shipping_service', 'created_at', 'estimated_delivery_at', 'delivered_at', 'time_to_deliver', 'earlier_days', 'delay_days'])}} as id_delivery_info,
            id_order,
            shipping_service,
            shipping_cost_USD,
            id_address,
            order_cost_USD,
            order_total_USD,
            id_tracking,
            status,
            created_at,
            estimated_delivery_at,
            delivered_at,
            time_to_deliver,
            delivery_info,
            earlier_days,
            delay_days,
            _fivetran_deleted,
            _fivetran_synced

        from order_delivery

    )

select * from  order_delivery_info

