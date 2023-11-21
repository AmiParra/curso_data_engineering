

with 

src_promos as (
    select * from {{ source('sql_server_dbo', 'promos') }}
    
),

transf_promos as (
    select
        upper(promo_id) as promo_id,
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as promo_id_hashed

from src_promos

)

select * from transf_promos

        --decode(promo_id, '', '9999', 'WITHOUT_PROMO') as promo_id