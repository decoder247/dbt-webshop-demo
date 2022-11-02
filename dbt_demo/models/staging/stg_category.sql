WITH source AS (
    SELECT
        *
    FROM
        {{ source(
            'webshop',
            'category'
        ) }}
)
SELECT
    id AS category_id,
    created_at,
    modified_at,
    NAME AS category_name
FROM
    source
