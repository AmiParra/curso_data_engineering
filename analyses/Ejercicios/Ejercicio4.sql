

-- {{
--     config(
--         materialized = 'ephemeral'
--     )

-- }}

-- WITH stg_events AS (
--     SELECT 
--     year(created_at)*10000+month(created_at)*100+day(created_at) as id_date_created
--     created_at as time_created

--     from src_sql_events
--     FROM {{ ref('stg_events') }}
-- ),


-- single_session AS (
--     SELECT
    
--     year(created_at)*1000000+month(created_date)*10000+day(created_at)*100+HOUR(creation_time) as hora,
--     count(distinct session_id) as num_sesiones,
--     FROM stg_events
--     group by 1
--     FROM stg_events
--     )

-- SELECT avg(num_sesiones) as Media_Sesiones 
-- from single_session


-- select * from stg_events