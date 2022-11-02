{{ config(
    materialized = 'view'
) }}

WITH order_info_expanded AS (

    SELECT
        *
    FROM
        {{ ref(
            'order_info_expanded'
        ) }}
),
stg_customer AS (
    SELECT
        *
    FROM
        {{ ref(
            'stg_customer'
        ) }}
)
SELECT
    interm.*,
    other.num_orders_per_customer
FROM
    (
        SELECT
            stg_customer.customer_id,
            stg_customer.customer_name,
            stg_customer.customer_email,
            stg_customer.customer_phone_number,
            order_info_expanded_agg.num_items_ordered
        FROM
            stg_customer
            LEFT OUTER JOIN (
                SELECT
                    order_info_expanded.customer_id,
                    SUM(
                        order_info_expanded.order_quantity
                    ) AS num_items_ordered
                FROM
                    order_info_expanded
                GROUP BY
                    order_info_expanded.customer_id
            ) AS order_info_expanded_agg
            ON stg_customer.customer_id = order_info_expanded_agg.customer_id
    ) AS interm
    LEFT OUTER JOIN (
        SELECT
            DISTINCT
            ON (
                order_info_expanded.customer_id
            ) order_info_expanded.customer_id,
            order_info_expanded.num_orders_per_customer
        FROM
            order_info_expanded
    ) AS other
    ON interm.customer_id = other.customer_id
ORDER BY
    customer_id ASC
