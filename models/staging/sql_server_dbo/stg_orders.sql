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
        cast({{ dbt_utils.generate_surrogate_key(['order_id']) }} as varchar) as id_order,
        -- order_id,
        -- shipping_service :: varchar as shipping_service,
        -- shipping_cost :: float as shipping_cost_USD,
        -- {{ dbt_utils.generate_surrogate_key(['address_id']) }} :: varchar as id_address,
        -- created_at :: date as created_at,
        -- estimated_delivery_at :: date as estimated_delivery_at,
        -- order_cost :: float as order_cost_USD,
        -- {{ dbt_utils.generate_surrogate_key(['user_id']) }} :: as varchar as id_user,
        -- order_total :: float as order_total_USD,
        -- delivered_at :: date as delivered_at,
        -- tracking_id :: varchar as id_tracking,
        -- status :: varchar as status,
        -- _fivetran_deleted,
        _fivetran_synced :: date as _fivetran_synced-- creo que voy a trabajar solo con date, sin time

    from source

)

select * from stg_orders



