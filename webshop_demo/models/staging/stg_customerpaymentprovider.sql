with source as (
    select * from {{ source('webshop', 'customerpaymentprovider') }}
)

select 
    id as customerpaymentprovider_id,
    created_at,
    modified_at,
    customer_id,
    provider,
    account_no
from source