#!/bin/bash
act workflow_dispatch \
 --secret-file .secrets \
    --input build_directory=caddy \
    --input registry="docker.io" \
    --input push_to_registry=true \
    -P ubuntu-latest=catthehacker/ubuntu:act-latest