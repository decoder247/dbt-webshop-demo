{{ config(
    materialized = 'view'
) }}

WITH source AS (

    SELECT
        *
    FROM
        {{ source(
            'webshop',
            'order'
        ) }}
)
SELECT
    id AS order_id,
    created_at,
    modified_at,
    customer_id,
    status AS order_status,
    customer_address_id
FROM
    source
