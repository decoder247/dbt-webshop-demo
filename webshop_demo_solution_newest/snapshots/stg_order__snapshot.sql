{% snapshot stg_order__snapshot %}

{{
    config(
      target_database='dbtdemo',
      target_schema='snapshots',
      unique_key='id',

      strategy='timestamp',
      updated_at='modified_at',
    )
}}

select * from {{ source('webshop', 'order') }}

{% endsnapshot %}