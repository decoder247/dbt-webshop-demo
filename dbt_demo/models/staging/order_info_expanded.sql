{{ config(
    materialized = 'view'
) }}

WITH stg_order AS (

    SELECT
        *
    FROM
        {{ ref(
            'stg_order'
        ) }}
),
stg_orderitem AS (
    SELECT
        *
    FROM
        {{ ref(
            'stg_orderitem'
        ) }}
)
SELECT
    interm.*,
    order_agg.num_orders_per_customer
FROM
    (
        SELECT
            stg_orderitem.orderitem_id,
            stg_orderitem.modified_at AS orderitem_modified_at,
            stg_orderitem.order_id,
            stg_orderitem.product_id,
            stg_orderitem.order_quantity,
            stg_orderitem.unit_price,
            --
            -- There are some values from orderitem above in which there is no order info below
            stg_order.modified_at AS order_modified_at,
            stg_order.customer_id,
            stg_order.order_status,
            stg_order.customer_address_id
        FROM
            stg_orderitem
            LEFT OUTER JOIN stg_order
            ON stg_orderitem.order_id = stg_order.order_id
    ) AS interm
    LEFT OUTER JOIN (
        SELECT
            stg_order.customer_id,
            SUM(1) AS num_orders_per_customer
        FROM
            stg_order
        GROUP BY
            stg_order.customer_id
    ) AS order_agg
    ON interm.customer_id = order_agg.customer_id
