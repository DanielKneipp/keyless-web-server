#!/usr/bin/env bash

set -e

aws ssm send-command \
    --document-name "run-nginx" \
    --document-version "1" \
    --targets '[{"Key":"tag:Name","Values":["server"]}]' \
    --parameters '{}' \
    --timeout-seconds 600 \
    --max-concurrency "50" \
    --max-errors "0" \
    --region us-east-1 \
    --no-paginate
