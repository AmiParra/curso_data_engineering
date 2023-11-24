
{{
  config(
    materialized='table'
  )
}}


with 

source as (

    select * from {{ source('sql_server_dbo', 'order_items') }}

),

stg_orders_items as (

    select
        cast({{ dbt_utils.generate_surrogate_key(['order_id']) }} as varchar) as id_order,
        order_id,
        cast({{ dbt_utils.generate_surrogate_key(['product_id']) }} as varchar) as id_product,
        product_id,
        cast(quantity as int) as quantity,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from stg_orders_items
