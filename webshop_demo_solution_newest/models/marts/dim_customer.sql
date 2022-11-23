with customer as (
    select * from {{ ref('stg_customer') }}
),

customer_address as (
    select * from {{ ref('stg_customeraddress') }}
)

select
    customer.*,
    customer_address.street,
    customer_address.number,
    customer_address.city,
    customer_address.postal_code,
    customer_address.country
from customer
left join customer_address on customer_address.customer_id = customer.customer_id