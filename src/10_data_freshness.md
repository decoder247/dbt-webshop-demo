# Data Freshness

## Full vs Incremental Loading

### Full Load

A full load typically occurs when we need to guarantee the freshest set of data. Largely this is due to the complexities around incremental loading, and explaining that is out of the scope of this book. Usually, the complexities around full loads tend to be more resource related:

- reading all records in the source table
- deleting all records in the target table
- writing the entire source table to the target
- coordination and timing of the steps above

By default, DBT performas a full load.

### Incremental Loading

Retrieve only the latest records.

The first time a model is ran, a table is built using a full load. All subsequent runs will transform records in the source that you tell dbt to filter for, and then inserts them into the target table. Usually, these are records that have been created or modified since the last run, and so we want to bring them to the target to keep it as "up to date" as possible.

Let's add this feature to our *category* table and run it.

```python
{{
    config(
        materialized='incremental'
    )
}}
```

- Notice that *stg_category* is now a table instead of a view.
- Check the output of the terminal
  - `select x` versus `create view`
  - Summary shows 1 incremental model ran
- Run the models again and view the **incremental** output
  - Notice the numbers on the insert output
  - check the *stg_category* table (inserting duplicates)
  - We have to configure the logic to tell dbt how to find the records to insert (currently selecting everything)
- Remove the target table and re-run the models to restore original state, then make the change below

```sql
{{
    config(
        materialized='incremental'
    )
}}

with source as (
    select * from {{ source('webshop', 'category') }}
)

select 
    id as category_id,
    created_at,
    modified_at,
    name as category_name
from category

{% if is_incremental() %}
    -- this is only applied on an incremental run
    where id > (select max(category_id) from {{ this }})
{% endif %}
```

- Run the models again and observe this time that it doesn't do any inserts
- Insert a record into the source table and run the models to see that it inserts ONLY the new record
- Is the Primary Key always the best way to incrementally load?
- Update the inserted record and re-run
  - 0 records inserted, but we know that a record in the source was updated. So what can we do?

```sql
{% if is_incremental() %}
    -- this is only applied on an incremental run
    where
        id > (select max(category_id) from {{ this }}) or
        -- also use the modified at time
        modified_at > (select max(modified_at) from {{ this }})
{% endif %}
```

- run it and notice that we now have our new record, but our primary key is now duplicated, its probably best to have this updated instead
- delete the new record in *stg_category*
- Define a uniqueness constraint
  - determines whether the record from the source table should be appended or updated at the target

```python
{{
    config(
        materialized='incremental',
        unique_key=['category_id']
    )
}}
```

- run it again and now our target record has been updated
- this works great for mostly append-only tables like a fact table where you want to capture every fact that occurs but don't want to keep re-loading the table
- but for smaller tables like dimensions that may rarely change this isn't always ideal
  - the table is small, and doesn't change often so the benefits of incremental loading are negligible, and instead we've introduced complexity

## Snapshots

Scenario: if the price of a product changes, we might want to analyze the impact of this change, like knowing the number of orders over a certain period and comparing how it did at its previous price. But if we don't know when the price changed, how can we segregate the data and compare?

Snapshots are useful for handling this. They can live as downstream tables to be used actively, or as a historical record along side the table they represent history of.

Back to our category table, we will configure snapshots of it to work alongside our incrementally loaded categories.

In the **snapshot** directory of our project, create a file stg_category__snapshot.sql with the following code.

```sql
{% snapshot stg_category__snapshot %}

{{
    config(
      target_database='webshop',
      target_schema='public',
      unique_key='id',

      strategy='timestamp',
      updated_at='modified_at',
    )
}}

select * from {{ source('webshop', 'category') }}

{% endsnapshot %}
```

- revert our record from earlier
- run `dbt run` to show the incremental change again
- run `dbt snapshot` and view the stg_category__snapshot table
- update the record again, run both commands and view the differences

Snapshots provide more versatility in how you structure your data transformation phases. Snapshots could stand in as upstream tables that downstream tables are built from:

- the upside to this is that you reduce the number of tables you have to maintain
- the downside is that querying logic using the snapshot table is a bit more complex because you have to search for the version of a record that you want

## Strategy Thoughts

Keep things as simple as possible until absolutely needed:

- make all downstream tables a view
- once the view becomes too slow, materialize it as a table
- once creating the table becomes too slow, introduce incremental loading
- introduce snapshots only when/where needed

## Links

- [Full & Incremental Loading](https://docs.getdbt.com/docs/building-a-dbt-project/building-models/configuring-incremental-models)
- [DBT Snapshots](https://docs.getdbt.com/docs/building-a-dbt-project/snapshots)
