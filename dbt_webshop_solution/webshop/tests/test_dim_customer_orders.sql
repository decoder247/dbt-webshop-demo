select
	customer_name ,
	count(so.order_id) as number_of_orders
from {{ ref('stg_customer') }} sc
left join {{ ref('stg_order') }} so on so.customer_id = sc.customer_id 
group by sc.customer_id, sc.customer_name
having count(so.order_id) > 0

except 

select
    customer_name,
    number_of_orders
from {{ ref('dim_customer_orders') }}