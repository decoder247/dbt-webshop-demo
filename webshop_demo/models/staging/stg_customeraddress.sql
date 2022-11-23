with source as (
    select * from {{ source('webshop', 'customeraddress') }}
)

select 
    id as customeraddress_id,
    created_at,
    modified_at,
    customer_id,
    street,
    number,
    city,
    postal_code,
    country
from source