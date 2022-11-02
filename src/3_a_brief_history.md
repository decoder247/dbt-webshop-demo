# A Brief History

## The Database

Historically, relational databases, more or less, owned the realm of data storage and handling. These were technologies like: MSSQL (a.k.a SQL Server), Postgres, MySQL, Oracle, etc. So what were they good at?

- storing data
- working with data (SQL)
- coming up with tools to make working with that data easier
- relating data
- adding structure

What were they not so good at? (Or what became their weaknesses?)

- interactions with other technology, especially open-source
- version controlling
- making changes (multi-layered dependencies)

## ETL vs ELT

- Extract Transform Load
  - data pulled from a source into some external "staging" area
  - data transformed in the staging area
  - data loaded into the target

- Extract Load Transform
  - data pulled from a source
  - data loaded into the target
  - data transformed at the target

- ETL -> ELT mostly because the improvements of compute power with data store technologies

Perfect opportunity for something like DBT.
