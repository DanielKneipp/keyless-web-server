#!/usr/bin/env bash

set -e

aws ssm send-command \
    --document-name "AmazonCloudWatch-ManageAgent" \
    --document-version "6" \
    --targets '[{"Key":"tag:Name","Values":["server"]}]' \
    --parameters '{"action":["configure"],"mode":["ec2"],"optionalConfigurationSource":["default"],"optionalConfigurationLocation":[""],"optionalOpenTelemetryCollectorConfigurationSource":["default"],"optionalOpenTelemetryCollectorConfigurationLocation":[""],"optionalRestart":["yes"]}' \
    --timeout-seconds 600 \
    --max-concurrency "50" \
    --max-errors "0" \
    --region us-east-1 \
    --no-paginate
