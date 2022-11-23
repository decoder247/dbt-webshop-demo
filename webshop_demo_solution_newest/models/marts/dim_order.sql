with orders as (
    select * from {{ ref('stg_order') }}
)

select
    order_id,
    created_at,
    modified_at,
    status
from orders