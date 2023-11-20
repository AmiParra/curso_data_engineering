

with 

src_promos as (
    select * from {{ source('sql_server_dbo', 'promos') }}
    
),

upper_promos as (
    select
         upper(promo_id) as promo_id,
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as promo_id_hash
from src_promos

)

select * from upper_promos
