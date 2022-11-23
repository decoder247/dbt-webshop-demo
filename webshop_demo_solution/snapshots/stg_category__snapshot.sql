{% snapshot stg_category__snapshot %}

{{
    config(
      target_database='webshop',
      target_schema='public',
      unique_key='id',

      strategy='timestamp',
      updated_at='modified_at',
      invalidate_hard_deletes=True,
    )
}}

select * from {{ source('webshop', 'category') }}

{% endsnapshot %}