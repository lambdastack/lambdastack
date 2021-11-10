#!/usr/bin/env bash
# Build the Docker image of LambdaStack. This will publish to the local registry only

TAG=$(cat version)
docker build --file Dockerfile --tag lambdastack/example-python-helloworld:${TAG} --tag lambdastack/example-python-helloworld:latest .
