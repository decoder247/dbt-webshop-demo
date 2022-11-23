with source as (
    select * from {{ source('webshop', 'productbrand') }}
)

select 
    id as productbrand_id,
    created_at,
    modified_at,
    name as productbrand_name
from source