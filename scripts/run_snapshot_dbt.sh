#!/bin/bash

dbt snapshot \
    --project-dir webshop_demo \
    --profiles-dir webshop_demo \
    --target dev
