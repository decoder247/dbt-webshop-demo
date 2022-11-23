{{
    config(
        materialized='incremental',
        unique_key = ['orderitem_id']
    )
}}

with source as (
    select * from {{ source('webshop', 'orderitem') }}
)

select 
    id as orderitem_id,
    created_at,
    modified_at,
    order_id,
    product_id,
    quantity,
    price
from source

{% if is_incremental() %}
  where modified_at > (select max(modified_at) from {{ this }})
{% endif %}