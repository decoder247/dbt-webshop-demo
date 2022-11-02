# What is DBT?

DBT = Data Build Tool

- DBT is the **T** in ELT, the *Transform*
- It is a tool to write transformation logic using only *SELECT* statements
  - No more INSERT, UPDATE, DELETE logic or stored procedures
- By leverageing Jinja, you can:
  - inject variables into your SQL code so you can reuse logic and data sources
  - bring traditional software engineering logic into SQL to handle complex scenarios and prevent code repetition
    - if-else statements, for loops, etc.

    ```python
    {{ }}
    ```

## DBT Project Structure

- Templated SQL files
  - the core transformation logic
- YAML files for configuration
  - Database connections
  - Project architecture
  - Documentation
- JSON for web development
  - probably will never need to use/interact with this
