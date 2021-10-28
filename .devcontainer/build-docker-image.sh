#!/usr/bin/env bash
# Build the Docker image of LambdaStack. This will publish to the local registry only

cd ..
TAG=$(cat version)
docker build --file Dockerfile --tag lambdastack/lambdastack:${TAG} --tag lambdastack/lambdastack:latest .
