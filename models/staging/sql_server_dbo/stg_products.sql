{{
    config(
        tags=['Views'],
    )
}}


with 

source as (

    select * from {{ source('sql_server_dbo', 'products') }}

),

-- Como práctica, en todos los stg_ del proyecto se hashearan todos los id_ procedentes del 
-- operacional por dos razones:
--      - Para evitar que los id_ del operacional sean los mismos en el informacional (esto 
--        sería una buena practica generalizada para evitar problemas en caso de que cambie
--        la forma de las pk en el operacional)
--      - Asegurar que todos los id sean un hash.
-- Para todo ello se usará la función generate_surrogate_key del paquete dbt_utils


stg_products as (

    select
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} :: varchar as id_product,
        product_id,
        name :: varchar as product_name,
        price :: float as price_USD, -- USD: United States Dollars
        inventory :: int as stock, -- las unidades que forman el inventario son enteros
        _fivetran_deleted, -- procede de Fivetran como un bool
        _fivetran_synced :: date as _fivetran_synced-- creo que voy a trabajar solo con date, sin time

    from source

)

select * from stg_products
