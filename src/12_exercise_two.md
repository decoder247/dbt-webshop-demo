# Exercise Two

- create a star schema for our webshop
- choose some tables for incremental loading
- choose some tables to create snapshots of
- you can choose whether you want to use snapshots as tables alongside your models, or used as references for downstream models
- Stretch Goal: if you chose to create your snapshots as side tables in your pipeline, try implementing them directly as source tables for downstream models, and vice versa if you implemented them directly

Guidance for getting started:

1. Start by creating a staging section where you stage the following tables
   - category, customer, customeraddress, customerpaymentprovider, order, orderitem, paymentprovider, product, productbrand, productcatgory
   - for each table, think about what columns are needed, what data types they should be, and also their names
2. For creating the star schema, look at your staging tables and think about which table/s are an event, and which tables describe the event. It helps to put yourself in the shoes of the webshop owner.
   - A picture/diagram is always a good place to start
