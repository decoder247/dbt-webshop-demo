# DBT packages

Packages in DBT are analogous with libraries in software engineering. And just like libraries, packages contain macros (functions) that can be leveraged in place of writing the functionality out yourself.

To add and use a package (like pip install + import for python):

- create a `packages.yml` at the root of your project (where `dbt_project.yml` is)
- add the package and version info to it

  ```yaml
  packages:
    - package: dbt-labs/dbt_utils
      version: 0.9.2
  ```

- run `dbt deps` (this is like pip install)

The dbt_utils package contains many useful functionality for performing common tasks when working with a data warehouse. For an example, we'll create a date spine. In other words, we will create a table with one column that is full of dates from a start to an end, each a day apart.

- in our staging folder, we will create stg_date_spine.sql, and place the following in it

  ```python
    {{
        dbt_utils.date_spine(
            datepart="day",
            start_date="cast('2019-01-01' as date)",
            end_date="cast('2020-01-01' as date)"
        )
    }}
  ```

- `dbt run` and then check our new table **stg_date_spine**
- you can visit the target folder to see the compiled sql of this function to realize how much time and effort was saved

## Links

- [Packages](https://docs.getdbt.com/docs/build/packages)
- [DBT Hub](https://hub.getdbt.com/)
