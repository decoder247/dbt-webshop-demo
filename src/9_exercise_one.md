# Exercise One

1. Create a staging layer
   - this is usually an area for landing source data into the target
   - typically there is minimal manipulation that should be done to the data
     - renaming columns
     - casting column types
     - simple calculations (like standardizing currency)
2. Create a table that shows the amount of orders that each customer has made
   - use the staging layer to create this table
3. Stretch goals
   - add another column to the above table that shows the total number of products each customer has ordered
   - add another column to show what category of product each customer tends to buy

- use sources and references appropriately
- generate the docs to show the DAG
- use some tests on the sources and the dimension table to ensure data quality
