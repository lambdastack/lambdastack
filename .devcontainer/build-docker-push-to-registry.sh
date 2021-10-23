#!/usr/bin/env bash
# Build the Docker image of LambdaStack and publish to it's registry at hub.docker.io

cd ..
TAG=$(cat version)
docker build --file Dockerfile --tag lambdastack/lambdastack:${TAG} --tag lambdastack/lambdastack:latest .

docker push lambdastack/lambdastack:${TAG}
docker push lambdastack/lambdastack:latest
