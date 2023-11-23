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
        decode(promo_id,'',{{ dbt_utils.generate_surrogate_key(['9999']) }},{{ dbt_utils.generate_surrogate_key(['upper(promo_id)']) }}) as id_promo,
        decode(promo_id,'','WITHOUT-PROMO',upper(promo_id)) as  promo_desc,
        order_id,
        shipping_service,
        shipping_cost,
        address_id,
        created_at,
        estimated_delivery_at,
        order_cost,
        user_id,
        order_total,
        delivered_at,
        tracking_id,
        status,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from stg_orders;



