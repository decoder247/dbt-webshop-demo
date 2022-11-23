with source as (
    select * from {{ ref('stg_order__snapshot') }} where dbt_valid_to is null
)

select 
    id as order_id,
    created_at,
    modified_at,
    customer_id,
    status,
    customer_address_id as customeraddress_id
from source