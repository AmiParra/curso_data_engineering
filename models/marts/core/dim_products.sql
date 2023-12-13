

with product as (
    select * from {{ ref('stg_products') }}
    ),

dim_products as (
    select 
        id_product,
        product_name,
        price_USD,
        case
            when price_USD >= 30 then 'B2B'
            else 'B2C'
        end as business,
        _fivetran_synced
        
    from product
)

select * from dim_products