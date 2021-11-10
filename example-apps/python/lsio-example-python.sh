#!/bin/bash
# This is only a basic shell script that launches examples for LambdaStack not on Kubernetes
# There are helm charts for the examples to be deployed on Kubernetes

set -e

EXAMPLE=$1

# TODO - Add error check of passed example...

# Colors
GREEN="\033[1;32m"
NOCOLOR="\033[0m"

# Default values
LOCAL=false

if [[ ! $LOCAL ]]; then
    # If the LOCAL var is not true then pull from the registry
    docker pull lambdastack/example-python-$EXAMPLE:$(cat $EXAMPLE/version)
fi

echo
echo
echo -e "${GREEN} >>>> Launching LambdaStack Python Example - $EXAMPLE <<<< ${NOCOLOR}"
echo
echo -e "Type http://127.0.0.1:8080 in your local browser or if using curl or wget"
echo
# Optional params for passing to create color. Default is to add it in Dockerfile -- -e "TERM=xterm-256color"
docker run --rm -p 8080:3333 lambdastack/example-python-$EXAMPLE:$(cat $EXAMPLE/version)

echo
echo
echo -e "${GREEN} >>>> Exiting LambdaStack Python Example <<<< ${NOCOLOR}"
echo
echo