#!/bin/bash

# Build the LambdaStack doc site.

rm -rf public/
HUGO_ENV="production" hugo --gc || exit 1
s3deploy -source=public/ -region=us-east-1 -bucket=www.lambdastackio.com -acl='public-read'