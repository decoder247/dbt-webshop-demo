{{ config(
    materialized = 'incremental',
    unique_key = ['category_id']
) }}

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

{% if is_incremental() %}
-- this is only applied on an incremental run
WHERE
    id > (
        SELECT
            MAX(category_id)
        FROM
            {{ this }}
    )
    OR -- also use the modified at time
    modified_at > (
        SELECT
            MAX(modified_at)
        FROM
            {{ this }}
    )
{% endif %}
