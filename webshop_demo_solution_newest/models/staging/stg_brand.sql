with source as (
    select * from {{ ref('stg_brand__snapshot') }} where dbt_valid_to is null
)

select 
    id as productbrand_id,
    created_at,
    modified_at,
    name as brand_name
from source