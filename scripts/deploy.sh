#!/bin/bash

# build docker image if it doesn't exist yet
echo "Checking if the appropriate image exists..."
if [[ "$(docker images -q extract_load:latest 2> /dev/null)" == "" ]]; then
    echo "Extract Load image does not exist yet... building it now..."
    docker build -t extract_load .
fi

echo "sleeping for 5 seconds"
sleep 5

# create namespaces
echo "creating namespaces"
kubectl apply -f kubernetes/namespaces.yaml

echo "sleeping for 3 seconds"
sleep 3

# deploy pods
kubectl apply -f kubernetes/postgres -n postgres
kubectl apply -f kubernetes/pgadmin -n pgadmin

echo "sleeping for 2 minutes"
sleep 120

echo "waiting for postgres to be ready"
kubectl wait --for=condition=ready pod postgres-0 -n postgres

# copy schema file into postgres
echo "copying schema file into postgres"
kubectl cp $PWD/scripts/schema.sql postgres/postgres-0:/usr/src/schema.sql

echo "sleeping for 10 seconds"
sleep 10

echo "applying schema to the postgres database"
kubectl exec -i postgres-0 -c postgres -n postgres -- psql --file=/usr/src/schema.sql --dbname postgresql://postgres:dbt_demo@postgres-service:5432/webshop

echo "sleeping for 5 seconds"
sleep 5

echo "running extract-load"
kubectl apply -f kubernetes/extract-load -n extract-load