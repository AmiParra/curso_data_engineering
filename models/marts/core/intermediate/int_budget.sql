



with 

    budget as (select * from {{ ref('stg_budget') }}),

    products as (select *

                from {{ ref('stg_products') }}
    ),

    prod_budget as (

        select
            b.id_budget,
            b.budget_id,
            b.month_budget,
            b.estimated_quantity,
            p.id_product,
            p.product_id,
            p.product_name,
            p.price_USD,
            p.stock,
            b._fivetran_synced 
        
        from budget b LEFT JOIN products p
            on b.product_id = p.product_id
    )

    select * from prod_budget