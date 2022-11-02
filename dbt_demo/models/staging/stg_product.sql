{{ config(
    materialized = 'view'
) }}

WITH source AS (

    SELECT
        *
    FROM
        {{ source(
            'webshop',
            'product'
        ) }}
)
SELECT
    id AS product_id,
    created_at,
    modified_at,
    NAME AS product_name,
    description AS product_description,
    "EAN",
    ROUND(CAST(price AS numeric), 2) AS price,
    discount_percent,
    brand_id,
    inventory,
    published
FROM
    source
