with customer as (
    select * from {{ ref('stg_customer') }}
),

"order" as (
    select * from {{ ref('stg_order') }}
),

customer_order as (
    select
        customer_id,
        count(1) as number_of_orders
    from "order"
    group by customer_id
),

final as (
    select
        customer.customer_id,
        customer.customer_name,
        customer_order.number_of_orders
    from customer
    left join customer_order on customer_order.customer_id = customer.customer_id
    where number_of_orders is not null
    order by number_of_orders desc
)

select * from final