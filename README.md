# dbt-training

Training focused on introducing key dbt concepts, uses, and even a sample project

## Table of contents

- [Table of contents](#table-of-contents)
- [How to open this book](#how-to-open-this-book)
- [Credentials](#credentials)
- [Setting up the database // Restore a backup](#setting-up-the-database--restore-a-backup)
- [Running dbt docs](#running-dbt-docs)
- [Advantages of DBT](#advantages-of-dbt)
- [Learnings](#learnings)
- [Cool DBT packages](#cool-dbt-packages)

## How to open this book

There are 2 options for going through the book, outlined below:

1. Directly w/ Github [dbt-training](https://github.com/Xccelerated/dbt-training/blob/main/src/SUMMARY.md)
2. Opening the book locally
   1. [Install Rust & Cargo](https://doc.rust-lang.org/cargo/getting-started/installation.html#install-rust-and-cargo)
   2. Install mdbook
      - `cargo install mdbook`
   3. Clone this github repository
      - `git clone git@github.com:Xccelerated/dbt-training.git`
      - `cd dbt-training`
   4. Run
      - `mdbook serve --open`
      - the book should then open up in your browser (if not, you may need to pass a different port to the previous command)

## Credentials

**PGAdmin credentials**

```
- User: user@domain.com
- Pass: pgadmin
```

**Server connection details (dbtdemo)**

```
- Conn: postgres-service.postgres.svc.cluster.local
- User: postgres
- Pass: dbt_demo
- Port: 5432
```

## Setting up the database // Restore a backup

1. Start up the database by executing the convenience script from projet root `source scripts/deploy.sh`
2. Enter into the dbt environment `source scripts/activate_env.sh`
3. Login to the pgadmin database in `localhost:8888` using the *PGAdmin credentials* provided above
4. Create a new server connection (`dbtdemo`) using the *Server connection details above*
5. Copy db backup into container (available on basecamp, also placed on `db_backup_file`)
    - `kubectl cp ${PWD}/webshop.backup pgadmin/pgadmin-59b8d57fc9-gqxjm:/var/lib/pgadmin/storage/user_domain.com/`
6. Right click on the `webshop` database, click `restore`, and then select the db backup file. In the `options` tab, also select `Clean before restore` so that there won't be an error (and the current database is wiped, before the restore is applied)

*Decomissioning NOTE:*

- To run everything back down, use `kubectl delete -f <filename>`

## Running dbt docs

## Advantages of DBT

- Version controlling
- Documentation out the box
- Data lineage
- Moving away from overly complex stored procedures

## Learnings

- There are 2 yaml (sources and models)
- In these, tests can be defined. Sources can be seen as how the data is entered, and then models are how the final models are made available based on the sql files defined.

- A snapshot: Is like the original table with a changelog column, i.e. when it is modified

## Cool DBT packages

- DBT ML for preprocessing
- DBT audit helper (<https://github.com/dbt-labs/dbt-audit-helper>)
