

WITH src_budget_products AS (
    SELECT * 
    FROM {{ source('google_sheets', 'budget') }}
    ),

renamed_casted AS (
    SELECT
        
        {{ dbt_utils.generate_surrogate_key(['_row']) }} as id_budget,
        _row as budget_id,
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} as id_product,
        product_id,
        quantity as estimated_quantity,
        month as month_budget,
        _fivetran_synced 
    FROM src_budget_products
    )

SELECT * FROM renamed_casted