
{{
  config(
    materialized='table'
  )
}}



-- El siguiente WITH crea una ECT en Snowflake, esto hace que la performance de SNowfl sea
-- mejor, pero es una tabla temporal que no se materializa en ningún sitio, es una cuestión interna.
-- Cuidado con los paréntisis y las comas, es código propio de Snowflake y puede dar muchos errores.
with 

source as (

    select * from {{ source('sql_server_dbo', 'addresses') }}

),

stg_addresses as (

    select
        address_id,
        zipcode,
        country,
        address,
        state,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from stg_addresses
