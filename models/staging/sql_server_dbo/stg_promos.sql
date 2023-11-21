
{{
  config(
    materialized='table'
  )
}}


with 

source as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

stg_promos as (

    select
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as id_promo,
        upper(promo_id) as promo_desc,
        discount,
        status,
        _fivetran_deleted,
        _fivetran_synced

    from source

)


select * from stg_promos
union all
select
    '9999' as id_promo,
    'SIN PROMO' as promo_desc,
    null as discount,
    null as status,
    null as _fivetran_deleted,
    null as _fivetran_synced

