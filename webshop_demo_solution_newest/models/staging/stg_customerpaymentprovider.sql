with source as (
    select * from {{ ref('stg_customerpaymentprovider__snapshot') }} where dbt_valid_to is null
)

select 
    id as customerpaymentprovider_id,
    created_at,
    modified_at,
    customer_id,
    provider,
    account_no
from source