with source as (
    select * from {{ ref('stg_category__snapshot') }} where dbt_valid_to is null
)

select 
    id as category_id,
    created_at,
    modified_at,
    name as category_name
from source