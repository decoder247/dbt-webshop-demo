with source as (
    select * from {{ ref('stg_productcategory__snapshot') }} where dbt_valid_to is null
)

select 
    id as productcategory_id,
    created_at,
    modified_at,
    category_id,
    product_id
from source