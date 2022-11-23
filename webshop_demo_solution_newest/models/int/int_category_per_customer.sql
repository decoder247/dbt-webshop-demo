-- staging tables needed
with orders as (
    select * from {{ ref('stg_order') }}
),

order_items as (
    select * from {{ ref('stg_orderitem') }}
),

product_categories as (
    select * from {{ ref('stg_productcategory') }}
),

categories as (
    select * from {{ ref('stg_category') }}
),
-----------------------------

--- get the most common products ---

-- 1. use orders for the customerid, orderitems for the productid, productcategories for the categoryid, categories for the category name
-- group customers and category name and sum the quantity
most_common_category as (
    select
        orders.customer_id,
        categories.category_name,
        sum(order_items.quantity) as sum_product_categories
	from orders
    left join order_items on order_items.order_id = orders.order_id
    left join product_categories on product_categories.product_id = order_items.product_id
    left join categories on categories.category_id = product_categories.category_id
	-- where orders.customer_id in (44, 704)
	group by 
        orders.customer_id,
        categories.category_name
),
--

-- 2. rank the categories base on quantity --
ranked as (
	select
		*,
		dense_rank() over(partition by customer_id order by sum_product_categories desc) as rnk
	from most_common_category
),
--------

-- 3. retrieve grap only the top ranked categories for each customer --
only_top as (
	select
		*
	from ranked
	where rnk = 1
),
--------

------------
-- due to some ties of categories for any customer, duplicates appear in our data
-- the customer has deemed this undesirable and for now has said to give them the
-- first one that appears alphabetically, and will figure out another method in the future
------------

-- 4. order the categories alphabetically for each customer --
rownum_for_dupes as (
	select
		*,
		row_number() over(partition by customer_id order by category_name) as rownum_alpha
	from only_top
),
--------

-- 5. grab the first one --
final as (
	select
		customer_id,
		category_name
	from rownum_for_dupes
	where rownum_alpha = 1
)
--------
-------------------------------------

select * from final
