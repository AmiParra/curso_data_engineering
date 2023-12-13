{{
    config(
        tags='Views'
    )
}}



-- El siguiente WITH crea una CTE en Snowflake, esto hace que la performance de SNowfl sea
-- mejor, pero es una tabla temporal que no se materializa en ningún sitio, es una cuestión interna.
-- Cuidado con los paréntisis y las comas, es código propio de Snowflake y puede dar muchos errores.


-- Como práctica, en todos los stg_ del proyecto se hashearan todos los id_ procedentes del 
-- operacional por dos razones:
--      - Para evitar que los id_ del operacional sean los mismos en el informacional (esto 
--        sería una buena practica generalizada para evitar problemas en caso de que cambie
--        la forma de las pk en el operacional)
--      - Asegurar que todos los id sean un hash.
-- Para todo ello se usará la función generate_surrogate_key del paquete dbt_utils

with base_stg_addresses as (

    select
        {{ dbt_utils.generate_surrogate_key(['address_id']) }} :: varchar as id_address,
        address_id,
        zipcode,
        country :: varchar as country,
        address :: varchar as address,
        state :: varchar as state,
        _fivetran_deleted, -- procede de Fivetran como un bool
        _fivetran_synced :: date as _fivetran_synced-- creo que voy a trabajar solo con date, sin time

    from {{ source("sql_server_dbo", "addresses_hist") }} where _fivetran_deleted = false or _fivetran_deleted is null

)

select * from base_stg_addresses