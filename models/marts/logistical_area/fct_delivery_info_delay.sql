WITH int_ord_del AS (
    SELECT * FROM {{ ref('int_orders_delivery_info') }}

    --, d_shipping_service AS (SELECT * FROM {{ ref('dim_shipping_service') }})
),
metrics AS (
    SELECT
        id_order,
        shipping_service,
        time_to_deliver,
        delivery_info,
        --earlier_days,
        delay_days,
        AVG(delay_days) OVER (PARTITION BY shipping_service) AS avg_delay_serv
    FROM int_ord_del
    WHERE delay_days > 0
)
SELECT * FROM metrics
ORDER BY avg_delay_serv desc
