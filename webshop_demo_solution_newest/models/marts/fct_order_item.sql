with orderitems as (
    select * from {{ ref('stg_orderitem') }}
),

orders as (
    select * from {{ ref('stg_order') }}
),

final as (
    select
        orderitems.*,
        orders.customer_id 
    from
        orderitems
        left join orders on orders.order_id = orderitems.order_id
)

select
    orderitem_id,
    created_at,
    modified_at,
    quantity,
    price,
    order_id,
    product_id,
    customer_id
from final

