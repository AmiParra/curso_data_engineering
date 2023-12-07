with 

source as (

    select * from {{ source('my_stages', 'my_stg_addresses') }}

),

renamed as (

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

    from source

)

select * from renamed
