
{{
  config(
    materialized='table'
  )
}}


with 

source as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

-- Como práctica, en todos los stg_ del proyecto se hashearan todos los id_ procedentes del 
-- operacional por dos razones:
--      - Para evitar que los id_ del operacional sean los mismos en el informacional (esto 
--        sería una buena practica generalizada para evitar problemas en caso de que cambie
--        la forma de las pk en el operacional)
--      - Asegurar que todos los id sean un hash.
-- Para todo ello se usará la función generate_surrogate_key del paquete dbt_utils

stg_promos as (

    select
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as id_promo,
       -- promo_id es la descripción en minuscula,
        upper(promo_id) :: varchar as promo_description,
        discount :: float as discount_USD, -- descuento  en United States Dollars
        status :: varchar as status,
        _fivetran_deleted,
        _fivetran_synced :: date as _fivetran_synced-- creo que voy a trabajar solo con date, sin time
    from source

)

-- Para considerar el caso en el que no haya ninguna promocicón aplicable, insertamos
-- un registro para contemplar esa situación. Donde el id_promo corresponderá al 
-- hasheo del valor 9999 y la promo_description será WITH-OUT promo para dicho caso.

select * from stg_promos
union all
select
    {{ dbt_utils.generate_surrogate_key(['9999']) }} as id_promo,
    'WITHOUT-PROMO' as promo_description,
    null as discount_USD,
    null as status,
    null as _fivetran_deleted,
    null as _fivetran_synced

