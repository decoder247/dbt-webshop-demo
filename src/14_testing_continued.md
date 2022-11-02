# Testing Continued

While DBT comes equipped with some generic testing like we saw earlier, you have the potential to create a whole suite of tests.

Using the ./tests directory:

- create a sql file/s that run select queries
- run them with `dbt test`
- if the test queries output any rows, then the test will show as failed
  - so we need to write tests in a way that attempts to select records that should not be there
- lets test to make sure our dim_customer_orders table only contains customers who have made at least 1 order
- write our test, ./test/test_no_null_customer_orders.sql as such

```sql
select * from {{ ref('dim_customer_orders') }}
where number_of_orders is null
```

- we reference the model instead of calling out the table directly to ensure proper data lineage in our docs
- we have a failing test! now let's fix the issue by editing our model to make sure *number_of_orders* that are NULL are filtered out

## Links

[Testing](https://docs.getdbt.com/docs/build/tests)
