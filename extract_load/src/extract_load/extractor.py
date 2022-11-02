
import os
from sqlalchemy import create_engine
import pandas as pd
from io import StringIO
import psycopg2 as pg
import json
import csv


def pd_query(conn, query):
    conn = create_engine(conn)
    return pd.read_sql(sql=query, con=conn)


def pg_copy(conn, df, target_table):

    def jsonify_record(x):
        return json.dumps(x)

    def jsonify_column(x):
        if type(x[0]) is dict:
            c = x.apply(jsonify_record)
            return c
        else:
            return x

    df_quoted = df.apply(jsonify_column)

    buffer = StringIO()
    df_quoted.to_csv(buffer, index=False, header=False, sep='\t', quoting=csv.QUOTE_NONE)
    buffer.seek(0)

    conn = pg.connect(dsn=conn)
    
    cursor = conn.cursor()
    try:
        cursor.copy_from(buffer, target_table, sep="\t", null="")
        conn.commit()
    except (Exception, pg.DatabaseError) as error:
        print("Error: %s" % error)
        conn.rollback()
        cursor.close()
        return 1

    print("copy_from_stringio() done")
    cursor.close()
