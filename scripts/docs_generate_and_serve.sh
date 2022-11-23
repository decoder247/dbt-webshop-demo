#!/bin/bash

dbt docs generate \
    --project-dir ${PWD}/webshop_demo \
    --profiles-dir ${PWD}/webshop_demo \
    --target-path ${PWD}/webshop_demo/target &&
    dbt docs serve \
        --project-dir ${PWD}/webshop_demo \
        --profiles-dir ${PWD}/webshop_demo \
        --port 8001
