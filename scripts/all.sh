#!/usr/bin/env bash

set -e

export AWS_PAGER=""

./install-cloudwatch-agent.sh
./install-docker.sh
sleep 60

./configure-cloudwatch-agent.sh
./run-nginx.sh
