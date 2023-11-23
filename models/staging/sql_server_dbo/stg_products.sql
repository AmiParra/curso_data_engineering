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
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} as id_product,
        price as price_USD,
        name,
        inventory,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from stg_products
