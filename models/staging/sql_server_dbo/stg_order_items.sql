
{{
  config(
    tags='Views'
  )
}}


with 

source as (

    select * from {{ source('sql_server_dbo', 'order_items') }}

),

stg_order_items as (

    select
        {{ dbt_utils.generate_surrogate_key(['order_id', 'product_id']) }} :: varchar as id_order_items,
        --order_id as id_order,
        cast({{ dbt_utils.generate_surrogate_key(['order_id']) }} as varchar) as id_order,
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} :: varchar as id_product,
        quantity :: int as quantity,
        _fivetran_deleted,
        _fivetran_synced :: date as _fivetran_synced

    from source

)

select * from stg_order_items
