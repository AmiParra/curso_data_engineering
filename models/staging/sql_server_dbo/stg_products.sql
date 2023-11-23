{{
  config(
    materialized='table'
  )
}}


with 

source as (

    select * from {{ source('sql_server_dbo', 'products') }}

),

stg_products as (

    select
        product_id,
        price as price_USD,
        name,
        inventory,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from stg_products
