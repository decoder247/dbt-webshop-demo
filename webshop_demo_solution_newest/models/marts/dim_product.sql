with product as (
    select * from {{ ref('stg_product') }}
),

productcategory as (
    select * from {{ ref('stg_productcategory') }}
),

category as (
    select * from {{ ref('stg_category') }}
),

brand as (
    select * from {{ ref('stg_brand') }}
),

final as (
    select
        product.*,
        category.category_name,
        brand.brand_name
    from product
    left join productcategory on productcategory.product_id = product.product_id
    left join category on category.category_id = productcategory.category_id
    left join brand on brand.productbrand_id = product.productbrand_id
)


select
    product_id,
    created_at,
    modified_at,
    product_name,
    product_description,
    ean,
    price,
    discount_percent,
    inventory,
    published,
    category_name,
    brand_name
from final