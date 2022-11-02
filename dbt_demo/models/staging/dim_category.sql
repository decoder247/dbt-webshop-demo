WITH category AS (
    SELECT
        *
    FROM
        {{ ref('stg_category') }}
)
SELECT
    category_id AS id,
    category_name AS NAME
FROM
    category
