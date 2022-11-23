-- staging tables needed
with customers as (
    select * from {{ ref('stg_customer') }}
),

orders_per_customer as (
    select * from {{ ref('imd_orders_per_customer') }}
),

products_per_customer as (
    select * from {{ ref('imd_products_per_customer') }}
),

category_per_customer as (
    select * from {{ ref('imd_category_per_customer') }}
),
-----------------------------

--- join the metrics back onto the customers table ---
final as (
    select
        customers.*,
        orders_per_customer.num_orders_per_customer,
        products_per_customer.num_products_per_customer,
        category_per_customer.category_name
    from customers
    left join orders_per_customer on orders_per_customer.customer_id = customers.customer_id
    left join products_per_customer on products_per_customer.customer_id = customers.customer_id
    left join category_per_customer on category_per_customer.customer_id = customers.customer_id
)
-----------------------------------

select * from final
