select * from {{ ref('dim_customer_orders') }}
where number_of_orders is null