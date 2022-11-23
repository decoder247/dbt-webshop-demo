-- staging tables needed
with orders as (
    select * from {{ ref('stg_order') }}
),

order_items as (
    select * from {{ ref('stg_orderitem') }}
),
-----------------------------

---- get number of products from each customer ---
final as (
    select
        orders.customer_id,
        sum(order_items.quantity) num_products_per_customer
    from order_items
    left join orders on orders.order_id = order_items.order_id
    where orders.customer_id is not null
    group by orders.customer_id
)
----------------------------------

select * from final