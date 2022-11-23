with source as (
    select * from {{ source('webshop', 'paymentprovider') }}
)

select 
    id as paymentprovider_id,
    created_at,
    modified_at,
    name as paymentprovider_name,
    fixed_payment_costs,
    percentage_payment_costs
from source