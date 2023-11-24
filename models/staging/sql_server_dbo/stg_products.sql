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
        cast({{ dbt_utils.generate_surrogate_key(['product_id']) }} as varchar) as id_product,
        product_id,
        cast(name as varchar) as product_name,
        cast(price as float) as price_USD,
        cast(inventory as int) as inventory,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from stg_products
