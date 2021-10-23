# Build and Deploy LambdaStack

Here, in the .devcontainer directory, you can simply run the following:

```bash
./build-docker-push-to-registry.sh
```

This assumes you have of course have docker installed and have permission to push to LambdaStack registry. Anyone can pull a LambdaStack image but you need certain rights to push an image. It will allow anyone to build an image and store on their local docker registry.

The default image size will be somewhere around 1.6GB but it will compress down to below 400MBs.

>May add a parameter allowing you to pass in a registry of choice and it will default to lambdastack/lambdastack:latest by default.
