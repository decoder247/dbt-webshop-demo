with source as (
    select * from {{ source('webshop', 'customer') }}
)

select 
    id as customer_id,
    created_at,
    modified_at,
    name as customer_name,
    email,
    phone_number
from source