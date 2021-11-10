#!/bin/bash

# Build the LambdaStack doc site.

rm -rf public/
HUGO_ENV="production" hugo --gc || exit 1
