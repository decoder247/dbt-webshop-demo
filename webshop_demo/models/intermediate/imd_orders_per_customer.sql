-- staging tables needed
with orders as (
    select * from {{ ref('stg_order') }}
),
-----------------------------

--- get number of orders from each customer --
final as (
    select
        customer_id,
        count(order_id) num_orders_per_customer
    from orders
    group by customer_id
)
-------------------------------

select * from final
