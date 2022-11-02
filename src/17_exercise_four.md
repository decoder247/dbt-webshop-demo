# Exercise Four

- Explore more dbt packages in the [Hub](https://hub.getdbt.com/)
  - **logging**: for keeping track of things occurring
  - **dbt_profiler**: data profiling package, outputs distribution statistics for the data in your tables
  - **dbt_expectations**: bringing Great Expectations style testing to DBT
  - **dbtvault**: generates the ETL needed to run a Data Vault 2.0 Data Warehouse with the metadata you provide it
  - **elementary**: data observability platform that monitors data and dbt operations
  - **dbt_ml_preprocessing**: enables standardization of data sets & building fetures in your datawarehouse without needing Spark MLLib or Python scikit-learn
- Refactor existing complext sql to be dbtonic -> stored procedures
  - probably the most useful area where dbt can be applied today with most data warehouse logic living in a series of stored procs
  - at the root of this repo is a directory *refactoring* that contains all the materials needed
    - a .sql file that needs to be refactored into a proper dbt workflow
    - 3 csv files that can be used as seeds (the source data to work with this refactoring exercise)
      - see [seeds](https://docs.getdbt.com/docs/build/seeds) for more information on how to use these
    - for more information/a dbt tutorial to follow along with this, you can refer to [here](https://courses.getdbt.com/courses/refactoring-sql-for-modularity)
- [Metrics](https://docs.getdbt.com/docs/build/metrics): For creaing tables that are more suited with metrics gathering
- [Exposures](https://docs.getdbt.com/docs/build/exposures): Downstream use cases of the dbt project. Within DBT you can run, test & list the resources that feed this downstream project.
- [Python Models](https://docs.getdbt.com/docs/build/python-models): For uses cases that can't be solved with SQL
- [Other DBT connectors](https://docs.getdbt.com/docs/supported-data-platforms): Postgres is only one of many platforms that leverage DBT for managing data transformation
