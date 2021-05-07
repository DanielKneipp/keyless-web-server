#!/usr/bin/env bash

set -e

aws ssm send-command \
    --document-name "AWS-ConfigureAWSPackage" \
    --document-version "1" \
    --targets '[{"Key":"tag:Name","Values":["server"]}]' \
    --parameters '{"action":["Install"],"installationType":["Uninstall and reinstall"],"version":[""],"additionalArguments":["{}"],"name":["AmazonCloudWatchAgent"]}' \
    --timeout-seconds 600 \
    --max-concurrency "50" \
    --max-errors "0" \
    --region us-east-1 \
    --no-paginate
