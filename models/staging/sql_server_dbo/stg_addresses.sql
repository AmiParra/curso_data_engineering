{{
    config(
        materialized='incremental',
        unique_key=['id_address'],
        tags=['incremental'] 
    )
}}

with
    base_stg_addresses as (select * from {{ ref("base_stg_addresses") }}),

    base_my_stg_addresses as (select * from {{ ref("base_my_stg_addresses") }}),


    stg_addresses as (
        select 
            a.address_id,
            a.id_address,
            a.zipcode,
            a.address,
            m.major_city,
            a.state,
            a.country,
            m.latitude,
            m.longitude,
            m.geocoder_lat,
            m.geocoder_long,
            m.population,
            m.density_population,
            m.housing_units,
            a._fivetran_deleted,
            a._fivetran_synced

        from base_stg_addresses a
        left join base_my_stg_addresses m on a.zipcode = m.zipcode

)

select * from stg_addresses


{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}