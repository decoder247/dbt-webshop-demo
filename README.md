# dbt-training

Training focused on introducing key dbt concepts, uses, and even a sample project

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

Server connection details

- Conn: postgres-service.postgres.svc...
- User: postgres
- Pass: dbt_demo

## Restore a backup

1. Create a new database (i.e. dbtdemo)
2. Copy db backup into container (available on basecamp, also placed on `db_backup_file`)
    - `kubectl cp ${PWD}/webshop.backup pgadmin/pgadmin-59b8d57fc9-z2djz:/var/lib/pgadmin/storage/user_domain.com/`
3. Right click on the `dbtdemo` database, click restore, and then select the db backup file
