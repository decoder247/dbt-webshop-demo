# DBT Models

Models are the core feature in DBT. Where majority of the transformation logic is going to take place. Kind of like stored procedures, but better for reasons already mentioned, and that you have much more control in organization. DBT comes with some default examples that won't affect your current source tables. You can find these in ./models/example.

- Run `dbt run` to run these
  - What tables were created?
  - Why did this happen?
    - View the models syntax
    - DBT Best Practices really encourages use of CTEs (Common Table Expressions)
    - Look at the target/compiled SQL

- Note: compiled SQL shows the compiled DML (Data Modification Language), not any DDL (Data Definition Language)
  - DML -> select, insert, update, delete, etc.
  - DDL -> CREATE TABLE, DROP TABLE, ADD COLUMN, etc.

- Change the first model to create a view

  ```python
  # {{ config(materialized='table') }}

  {{ config(materialized='view') }}
  ```

  - what's going to happen?
    - first model table is removed
    - first model view is created
    - second model view is created off first model
- setting configuration in the model, controls configuration at the lowest level (highest level of precedence)
- use the *dbt_project.yaml* for higher level project configs
  - review and compare it with the directory structure
- change the example materialization in *dbt_project.yaml* to view

  ```yaml
  models:
  webshop:
    # Config indicated by + and applies to all files under models/example/
    example:
      +materialized: view # table
  ```

  - what will happen if we run again?
    - first model created as view
    - second model view removed
    - second model table created (no config specification in model)

## Create Models using our Source

- Create staging subdirectory within our models folder
  - **staging** is typically where we want to initially bring our data in from other sources, like a landing area
  - create a *_sources.yaml* file and a *_models.yaml* file within the *staging* subdirectory
    - _sources.yaml will host the configuration for any source data we want to use, document, test, etc.

      ```yaml
      version: 2

      sources:
        - name: webshop
          database: webshop
          schema: public
          description: Our webshop database as a source
          tables:
            - name: category
              description: The category table
      ```

    - _models.yaml will host configuration for models we want to use, document, test, etc.

      ```yaml
      version: 2

      models:
        - name: stg_category
      ```

  - create the stg_category model, using our source data
    - remember our models are our core logic, and these are just .sql files, so we will create a *stg_category.sql* file in the same directory and embed the following code

      ```sql
      with source as (
          select * from {{ source('webshop', 'category') }}
      )

      select 
          id as category_id,
          created_at,
          modified_at,
          name as category_name
      from category
      ```

    - all thats left is to run `dbt run` and DBT will pick up our new model and execute it appropriately
- Create a datamart section
  - **datamart** is often an analytical endpoint, meaning this is where we finally land our data
  - create dim_category
- when/how to reference a source or a model created by DBT
  - Referencing Sources: `{{ source(source_name, source_table) }}`
    - directly uses existing sources
  - Referencing Models: `{{ ref('model_name') }}`

## Links

- [DBT Models](https://docs.getdbt.com/docs/building-a-dbt-project/building-models)
