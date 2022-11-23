with source as (
    select * from {{ source('webshop', 'product') }}
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
    brand_id,
    inventory,
    published
from source