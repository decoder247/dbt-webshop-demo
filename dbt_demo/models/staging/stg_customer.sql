WITH source AS (
    SELECT
        *
    FROM
        {{ source(
            'webshop',
            'customer'
        ) }}
)
SELECT
    id AS customer_id,
    created_at,
    modified_at,
    NAME AS customer_name,
    email AS customer_email,
    phone_number AS customer_phone_number
FROM
    source
