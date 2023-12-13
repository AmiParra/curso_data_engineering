{{
    config(
        materialized='incremental',
        unique_key=['id_order'],
        tags=['order_incremental'] 
       
    )
}}

with 
    order_delivery as (
        select 
            decode(shipping_service,'',{{ dbt_utils.generate_surrogate_key(['9999']) }},{{ dbt_utils.generate_surrogate_key(['shipping_service']) }})  as id_shipping_service,
            decode(shipping_service, '', 'Non assigned', shipping_service) as shipping_service,
            id_order,
            shipping_cost_USD,
            order_cost_USD,
            order_total_USD,
            id_address,
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


)


select * from  order_delivery

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}