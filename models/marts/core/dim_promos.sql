{{
  config(
    materialized='incremental'
  )
}}


WITH stg_promos AS (
        SELECT * 
        FROM {{ ref('stg_promos') }}
    ),

    renamed_casted AS (

        SELECT
            id_promo,
            promo_description,
            discount_USD,
            status,
            _fivetran_synced as date_load,
            _fivetran_deleted as date_deleted
        FROM stg_promos
    )

SELECT *
FROM renamed_casted

{% if is_incremental() %}
where date_load > (select max(date_load) from {{ this }})
{% endif %}