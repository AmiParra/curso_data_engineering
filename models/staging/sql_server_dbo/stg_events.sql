-- {{
--   config(
--     materialized='table'
--   )
-- }}




-- with 

-- source as (

--     select * from {{ source('sql_server_dbo', 'events') }}

-- ),

-- -- Como práctica, en todos los stg_ del proyecto se hashearan todos los id_ procedentes del 
-- -- operacional por dos razones:
-- --      - Para evitar que los id_ del operacional sean los mismos en el informacional (esto 
-- --        sería una buena practica generalizada para evitar problemas en caso de que cambie
-- --        la forma de las pk en el operacional)
-- --      - Asegurar que todos los id sean un hash.
-- -- Para todo ello se usará la función generate_surrogate_key del paquete dbt_utils

-- REVISAR LA LÓGICA DE LA TABLA EN CUANTO A ORDER ID Y QUE NO HAYA HABIDO CHECK OUT Y DEMAS

-- stg_events as (

--     select
--         {{ dbt_utils.generate_surrogate_key(['event_id']) }} :: varchar as id_event,
--         event_id,
--         page_url :: varchar as page_url,
--         event_type :: varchar as page_url,
--         {{ dbt_utils.generate_surrogate_key(['user_id']) }} :: varchar as id_user,
--         user_id,
--         product_id,
--         session_id,
--         created_at,
--         order_id,
--         _fivetran_deleted,
--         _fivetran_synced

--     from source

-- )

-- select * from stg_events
