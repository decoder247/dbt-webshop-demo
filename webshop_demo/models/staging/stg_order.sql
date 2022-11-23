with source as (
    select * from {{ source('webshop', 'order') }}
)

select 
    id as order_id,
    created_at,
    modified_at,
    customer_id,
    status,
    customer_address_id as customeraddress_id
from source