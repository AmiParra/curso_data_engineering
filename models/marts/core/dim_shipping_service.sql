



with 
orders_delivery_info as (
    select * from {{ ref('int_orders_delivery_info') }}
),

dim_shipping_service as(
    select
        decode(dim_shipping_service,'',{{ dbt_utils.generate_surrogate_key(['9999']) }},{{ dbt_utils.generate_surrogate_key(['shipping_service']) }})  as id_delivery_info,
        cast(decode(promo_id,'','WITHOUT-PROMO',upper(promo_id)) as varchar) as  promo_description,
        cast(decode(promo_id,'','WITHOUT-PROMO',upper(promo_id)) as varchar) as  promo_description
        {{ dbt_utils.generate_surrogate_key(['shipping_service']) }} as id_delivery_info,
        shipping_service,
        created_at,
        delivery_info

    from orders_delivery_info

)

select * from dim_shipping_service

