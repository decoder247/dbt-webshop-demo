with source as (
    select * from {{ source('webshop', 'productcategory') }}
)

select 
    id as productcategory_id,
    created_at,
    modified_at,
    category_id,
    product_id
from source