with source as (
    select * from {{ ref('stg_product__snapshot') }} where dbt_valid_to is null
)

select 
    id as product_id,
    created_at,
    modified_at,
    name as product_name,
    description as product_description,
    'EAN' as ean,
    price,
    discount_percent,
    brand_id as productbrand_id,
    inventory,
    published
from source