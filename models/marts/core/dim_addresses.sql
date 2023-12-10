

with adress as (
    select * from {{ ref('stg_addresses') }}
    ),

dim_addresses as (
    select 
        id_address,
        zipcode,
        address,
        major_city,
        state,
        country,
        latitude,
        longitude,
        geocoder_lat,
        geocoder_long,
        population,
        density_population,
        housing_units,
        _fivetran_deleted,
        _fivetran_synced
        from adress
)

select * from dim_addresses