{{
    config(
        materialized='incremental',
        unique_key=['id_product'],
        tags=['incremental'] 
    )
}}

with product as (
    select * from {{ ref('stg_products') }}
    ),
dim_products as (
    select 
        id_product,
        product_name,
        price_USD,
        _fivetran_synced
        from product
)

select * from dim_products