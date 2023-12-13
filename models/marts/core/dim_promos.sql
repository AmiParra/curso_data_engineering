

with dim_promos as (
    select
        id_promo,
        promo_description,
        discount_USD,
        _fivetran_synced
    
    from {{ ref('stg_promos') }}
    
)

select * from dim_promos


