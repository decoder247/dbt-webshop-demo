with source as (
    select * from {{ ref('stg_paymentprovider__snapshot') }} where dbt_valid_to is null
)

select 
    id as paymentprovider_id,
    created_at,
    modified_at,
    name as paymentprovider_name,
    fixed_payment_costs,
    percentage_payment_costs
from source