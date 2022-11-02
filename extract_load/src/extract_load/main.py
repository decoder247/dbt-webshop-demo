import os
from extractor import pd_query, pg_copy
            

# get source environment variables
env_vars = ['WEBSHOP_HOST', 'WEBSHOP_PORT', 'WEBSHOP_USER', 'WEBSHOP_PASSWORD', 'WEBSHOP_DATABASE']
host, port, user, password, database = [os.getenv(x) for x in env_vars]

# create source and target connections
source = f'postgresql+psycopg2://{user}:{password}@{host}:{port}/{database}'
target = 'postgresql://postgres:dbt_demo@postgres-service.postgres.svc.cluster.local:5432/webshop'


# get list of source tables for syncing
table_list_query = """
select table_name from information_schema."tables" t 
where table_schema = 'public' and table_type = 'BASE TABLE'
"""
table_list = pd_query(conn=source, query=table_list_query)['table_name']


# for each table in table list
def add_target_data(target_table):
    print(f'starting table {target_table}')
    
    # get the existing target ids, if any
    target_ids_query = f"""
    select id from public.{target_table}
    """
    target_ids = pd_query(conn=target, query=target_ids_query)['id']

    # gather the source records
    source_records_query = f"""
    select * from public.{target_table}
    """
    source_records = pd_query(conn=source, query=source_records_query)

    # Filter for only the source records that do not match what exists in the target
    source_delta_records = source_records[~source_records.id.isin(target_ids)]
    
    # if len(target_ids) > 0:
    #     # incremental load
    #     target_ids_string = ', '.join(target_ids['id'].astype(str))

    #     source_delta_records_query = f"""
    #     select * from public.{target_table}
    #     where id not in ({target_ids_string})
    #     """
    # else:
    #     # full load
    #     source_delta_records_query = f"""
    #     select * from public.{target_table}
    #     """
    
    # source_delta_records = pd_query(conn=source, query=source_delta_records_query)

    # Append the new records to the target
    pg_copy(conn=target, df=source_delta_records, target_table=target_table)

    print(f'Done with {target_table}')


# Sync each table
[add_target_data(x) for x in table_list]
