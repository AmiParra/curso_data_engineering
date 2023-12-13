{{
  config(
    materialized='ephemeral'
  )
}}

with 

stg_users as (

    select * from {{ ref('stg_users') }}

),


renamed_casted as(

    select
        count(distinct user_id) as recuento
    from stg_users

)

select * from renamed_casted





