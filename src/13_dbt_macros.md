# DBT Macros

Macros in DBT are analagous to functions. These become very useful and help us to adhere to DRY (Don't Repeat Yourself) principles. An example of this is when needing to constantly convert currency values to a decided upon standard within your data warehouse, like everything to USD. However, this can also be abused as there exists a balance between too much abstraction and how readable your code is. DBT Best Practices leans more on valuing readable code, over code that has too many abstractions.

- lets make a macro for generating a schema name
- currently our example models exist in the public schema
- let's add them to a schema called *example*
  - Default behavior adds them to the target schema
  - DBT natively has custom schema creation that you can explicitly define
- adjust our *dbt_project.yaml* by adding the following

```yaml
models:
  webshop:
    example:
      +materialized: view
      # explicitly define the schema we want our examples to use, default is the target schema
      +schema: example
```

- `dbt run` to see that adding a custom schema by default concatenates <target_schema>_<custom_schema>
  - [DBT's reasons for this](https://docs.getdbt.com/docs/build/custom-schemas#why-does-dbt-concatenate-the-custom-schema-to-the-target-schema)
- use a macro to configure this functionality
  - create a file *./macros/generate_schema_name.sql* with the code below

```sql
{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}

        {{ default_schema }}

    {%- else -%}

        {{ default_schema }}_{{ custom_schema_name | trim }}

    {%- endif -%}

{%- endmacro %}
```

- read through it to see what is going on
- change the else statement logic to be

```sql
{%- else -%}

    -- {{ default_schema }}_{{ custom_schema_name | trim }}

    {{ custom_schema_name | trim }}
```

- running `dbt run` again will put our example models in the desired schema
- note however, that when objects are created in a new schema, they are not deleted from the previous one

## Links

[Macros](https://docs.getdbt.com/docs/building-a-dbt-project/jinja-macros)