with category as (
    select * from {{ ref('stg_category') }}
),

final as (
    select
        category_name,
        count(1)
    from category
    group by category_name
)

select * from final