# Generic Testing

Out of the box testing for data integrity.

Configure this for sources and models.

- uniqueness
- not null columns
- relationships for referential integrity
- and more!
  
  ```yaml
  sources:
  - name: webshop
    database: webshop
    schema: public
    description: Our webshop database as a source
    tables:
      - name: category
        description: The category table
        columns:
          - name: id
            description: Primary key of table
            tests:
              - unique
              - not_null
              - relationships:
                  to: source('webshop', 'productcategory')
                  field: category_id
  ```

run `dbt test`

## Links

- [Testing](https://docs.getdbt.com/docs/building-a-dbt-project/tests)
