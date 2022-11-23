#!/bin/bash

dbt run \
    --project-dir webshop_demo \
    --profiles-dir webshop_demo \
    --target-path webshop_demo/target \
    --log-path webshop_demo/logs \
    --target dev
