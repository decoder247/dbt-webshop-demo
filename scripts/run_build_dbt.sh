#!/bin/bash

dbt build \
    --project-dir webshop_demo \
    --profiles-dir webshop_demo \
    --log-path webshop_demo/logs \
    --target dev # --full-refresh  # will drop incremental models and full-recalculate
