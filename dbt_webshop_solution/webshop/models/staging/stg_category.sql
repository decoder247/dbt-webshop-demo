
{{
    config(
        materialized='incremental',
        unique_key=['category_id'],
    )
}}

with source as (
    select * from {{ source('webshop', 'category') }}
)

select 
    id as category_id,
    created_at,
    modified_at,
    name as category_name
from source

{% if is_incremental() %}
    -- this is only applied on an incremental run
    where
        id > (select max(category_id) from {{ this }}) or
        modified_at > (select max(modified_at) from {{ this }})
{% endif %}