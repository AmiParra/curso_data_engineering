

WITH int_ord_del AS (
    SELECT * FROM {{ ref('int_orders_delivery_info') }}

    --, d_shipping_service AS (SELECT * FROM {{ ref('dim_shipping_service') }})
),
metrics AS (
    SELECT
        shipping_service,
        time_to_deliver,
        delivery_info,
        earlier_days,
        delay_days,
        AVG(delay_days) OVER (PARTITION BY shipping_service) AS average_delay,
         COUNT(CASE WHEN delay_days > 0 THEN 1 END) OVER (PARTITION BY shipping_service) AS total_delays
    FROM int_ord_del

)

SELECT 
    shipping_service, 
    average_delay,
    total_delays
FROM metrics
GROUP BY shipping_service, average_delay, total_delays
ORDER BY total_delays DESC, average_delay DESC