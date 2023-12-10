{{
    config(
        tags=['Views'],
    )
}}

with 

source as (

    select * from {{ source('sql_server_dbo', 'users') }}

),

stg_users as (

    select
        cast({{ dbt_utils.generate_surrogate_key(['user_id']) }} as varchar) as id_user,
        cast({{ dbt_utils.generate_surrogate_key(['address_id']) }} as varchar) as id_address,
        cast(last_name as varchar) as last_name,
        cast(first_name as varchar) as first_name,
        cast(created_at as date) as created_at,
        cast(updated_at as date) as updated_at,
        cast(phone_number as varchar) as phone_number,
        total_orders,
        cast(email as varchar) as email,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from stg_users
