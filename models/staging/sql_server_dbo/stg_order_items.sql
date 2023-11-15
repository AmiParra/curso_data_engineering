
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
        order_id,
        product_id,
        quantity,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from stg_orders_items