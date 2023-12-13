

with users as (
      select * from {{ ref('stg_users') }}),

    users_addresses as (
      select * from {{ref('stg_addresses')}}),

dim_users as (
  select 
        u.id_user,
        u.first_name,
        u.last_name,
        u.phone_number,
        u.email,
        a.zipcode,
        a.address,
        a.major_city as city,
        a.state,
        a.country,
        u._fivetran_synced

  from users u left join users_addresses a
    on u.id_address = a.id_address
)

select * from dim_users

