# Getting Setup with DBT

## Initializing our Project

1. Create and activate a virtual environment
2. Install DBT
   1. `pip install dbt-postgres`
      - Postgres is one of many technologies that DBT plays well with. Look [here](https://docs.getdbt.com/docs/supported-data-platforms) for all supported adapters.
3. `dbt --version`

    ```cmd
    Core:
    - installed: 1.2.2
    - latest:    1.2.2 - Up to date!

    Plugins:
    - postgres: 1.2.2 - Up to date!
    ```

4. Initialize a DBT project `dbt init {project-name} --profiles-dir .`
   1. Creates a project subdir at `./{project-name}`
   2. Creates a profiles.yaml at the current directory (default is in your Users directory at `/Users/{user}/.dbt/`)

## Connecting to our Source database

Set environment variable **DBT_PROFILES_DIR**. We need to do this because DBT uses the default path to *profiles.yaml* for all commands.

Open up our *profiles.yaml*

```yaml
dev:
    type: postgres
    threads: 4
    host: localhost
    port: 5432
    user: postgres
    pass: dbt_demo
    dbname: webshop
    schema: public
```

Run `dbt debug` to make sure your source is working.

## Links

- [Installing DBT](https://docs.getdbt.com/dbt-cli/install/overview)
- [Working with Sources](https://docs.getdbt.com/docs/building-a-dbt-project/using-sources)
