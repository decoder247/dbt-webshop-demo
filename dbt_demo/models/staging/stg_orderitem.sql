{{ config(
    materialized = 'view'
) }}

WITH source AS (

    SELECT
        *
    FROM
        {{ source(
            'webshop',
            'orderitem'
        ) }}
)
SELECT
    id AS orderitem_id,
    created_at,
    modified_at,
    order_id,
    product_id,
    quantity AS order_quantity,
    ROUND(CAST(price AS numeric), 2) AS unit_price
FROM
    source
