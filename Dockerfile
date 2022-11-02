FROM python:3.10

RUN apt-get update -y && apt-get install -y build-essential libpq-dev
RUN pip install psycopg2-binary --no-binary psycopg2-binary

RUN pip install pandas sqlalchemy

WORKDIR /usr/app

COPY ./extract_load/src .


CMD [ "python", "extract_load/main.py" ]
