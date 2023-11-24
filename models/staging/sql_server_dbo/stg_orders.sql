{{
  config(
    materialized='table'
  )
}}



with 

source as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

stg_orders as (

select
        cast(decode(promo_id,'',{{ dbt_utils.generate_surrogate_key(['9999']) }},{{ dbt_utils.generate_surrogate_key(['upper(promo_id)']) }}) as varchar) as id_promo,
        cast(decode(promo_id,'','WITHOUT-PROMO',upper(promo_id)) as varchar) as  promo_description,
        cast(order_id as varchar) as id_order,
        cast(shipping_service as varchar) as shipping_service,
        cast(shipping_cost as float) as shipping_cost_USD,
        cast({{ dbt_utils.generate_surrogate_key(['address_id']) }} as varchar) as id_address,
        cast(created_at as date) as created_at,
        cast(estimated_delivery_at as date) as estimated_delivery_at,
        cast(order_cost as float) as order_cost_USD,
        cast(user_id as varchar) as id_user,
        cast(order_total as float) as order_total_USD,
        cast(delivered_at as date) as delivered_at,
        cast(tracking_id as varchar) as id_tracking,
        cast(status as varchar) as status,
        _fivetran_deleted as date,
        _fivetran_synced as date

    from source

)

select * from stg_orders



