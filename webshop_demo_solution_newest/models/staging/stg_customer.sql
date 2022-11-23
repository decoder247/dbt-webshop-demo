with source as (
    select * from {{ ref('stg_customer__snapshot') }} where dbt_valid_to is null
)

select 
    id as customer_id,
    created_at,
    modified_at,
    name as customer_name,
    email,
    phone_number
from source