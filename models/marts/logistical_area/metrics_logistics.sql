

WITH int_ord_del AS (
    SELECT * FROM {{ ref('int_orders_delivery_info') }}

    --, d_shipping_service AS (SELECT * FROM {{ ref('dim_shipping_service') }})
),




metrics AS (
    SELECT
        shipping_service,
        AVG(delay_days)  AS avg_delay,
        AVG(time_to_deliver)  AS avg_time_to_deliver,
        AVG(earlier_days) AS avg_earlier_days
    FROM int_ord_del
    where shipping_service <> 'Non assigned'
    GROUP BY shipping_service

)

SELECT * FROM metrics
ORDER BY avg_delay DESC
