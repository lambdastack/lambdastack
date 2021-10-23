## Run LambdaStack from Docker image

There are 2 ways to get the image, build it locally yourself or pull it from the LambdaStack docker registry.

### Option 1 - Build LambdaStack image locally

*Shows the option of pushing the locally generated image to Docker Hub as well.*

1. Install the following dependencies:

    - Docker

2. Open a terminal in the root directory of the LambdaStack source code and run (it should contain the /cli subdirectory. This also where the Dockerfile is located). There are two options below, the first option builds and applies a specific tag/version to the image and the second option builds and applies a specific tag/version plus applies a 'latest' tag in the event the user only wanted the latest version:

```bash
TAG=$(cat version)
docker build --file Dockerfile --tag lambdastack/lambdastack:${TAG} .
```

OR

```bash
TAG=$(cat version)
docker build --file Dockerfile --tag lambdastack/lambdastack:${TAG} --tag lambdastack/lambdastack:latest .
```

3. To push the image(s) to the default Docker Hub:
   1. Make sure to create an account at [Docker](https://hub.docker.com). If you want to have more than one repo then create an Organization and add yourself as a member. If organization, then select or create repo name. For example, we use LambdaStack as the organization and lambdastack as a repo (lambdastack/lambdastack). We actually have a number of repos but you get the point.
   2. Push the image(s) to Docker Hub as follows: (Note - 'latest' tag is optional and Docker will see it's the same and simply create latest reference link)

```bash
TAG=$(cat version)
docker push lambdastack/lambdastack:${TAG}
docker push lambdastack/lambdastack:latest
```


### Option 2a - Pull LambdaStack image from the registry

>NOTE: This the default way. The latest version of LambdaStack will already be in the Docker Hub ready to be pulled down locally. If you built the image locally then it will already be in your local image so there is no need to pull it down - you can skip to doing a Docker Run like below.

`TAG` is the specific version tag given to the image. If you don't know the specific version then use the second option and it will grab the latest version.
```bash
docker pull lambdastack/lambdastack:TAG
```

OR

```bash
docker pull lambdastack/lambdastack:latest
```

*Check [here](https://cloud.docker.com/u/lambdastack/repository/docker/lambdastack/lambdastack) for the available tags.*

### Option 2b - Running the LambdaStack image

To run the image:

```bash
docker run -it -v LOCAL_DIR:/shared --rm lambdastack/lambdastack:TAG
```

Where:
- `LOCAL_DIR` should be replaced with the local path to the directory for LambdaStack input (SSH keys, data yaml files) and output (logs, build states),
- `TAG` should be replaced with an existing tag.

>Example: docker run -it -v $PWD:/shared --rm lambdastack/lambdastack:latest

The lambdastack docker image will mount to **<present working directory>/shared**. `$PWD` means present working directory so, change directory to where you want it to mount. It will expect any customized configs, SSH keys or data yaml files to be in that directory. The example above is for Linux based systems (including macs). See Windows method below.

*Check [here](https://cloud.docker.com/u/lambdastack/repository/docker/lambdastack/lambdastack) for the available tags.*

Let LambdaStack run (it will take a while depending on the options you selected)!

*Notes below are only here if you run into issues with a corporate proxy or something like that or if you want to do development and add cool new features to LambdaStack :).*

---

## LambdaStack development

For setting up the LambdaStack development environment please refer to this dedicated document [here.](./../DEVELOPMENT.md)

## Important notes

### Hostname requirements

LambdaStack supports only DNS-1123 subdomain that must consist of lower case alphanumeric characters, '-' or '.',
and must start and end with an alphanumeric character.

### Note for Windows users

- Watch out for the line endings conversion. By default, Git for Windows sets `core.autocrlf=true`. Mounting such files with Docker results in `^M` end-of-line character in the config files.
Use: [Checkout as-is, commit Unix-style](https://stackoverflow.com/questions/10418975/how-to-change-line-ending-settings) (`core.autocrlf=input`) or Checkout as-is, commit as-is (`core.autocrlf=false`). Be sure to use a text editor that can work with Unix line endings (e.g. Notepad++).

- Remember to allow Docker Desktop to mount drives in Settings -> Shared Drives

- Escape your paths properly:

  - Powershell example:
  ```bash
  docker run -it -v C:\Users\USERNAME\git\LambdaStack:/LambdaStack --rm lambdastack-dev:
  ```
  - Git-Bash example:
  ```bash
  winpty docker run -it -v C:\\Users\\USERNAME\\git\\LambdaStack:/LambdaStack --rm lambdastack-dev
  ```

- Mounting NTFS disk folders in a linux based image causes permission issues with SSH keys. When running either the development or deploy image:

1. Copy the certs on the image:

    ```bash
    mkdir -p ~/.ssh/lambdastack-operations/
    cp /lambdastack/core/ssh/id_rsa* ~/.ssh/lambdastack-operations/
    ```
2. Set the proper permission on the certs:

    ```bash
    chmod 400 ~/.ssh/lambdastack-operations/id_rsa*
    ```

### Note about proxies

To run LambdaStack behind a proxy, environment variables need to be set.

When running a development container (upper and lowercase are needed because of an issue with the Ansible dependency):

  ```bash
  export http_proxy="http://PROXY_SERVER:PORT"
  export https_proxy="https://PROXY_SERVER:PORT"
  export HTTP_PROXY="http://PROXY_SERVER:PORT"
  export HTTPS_PROXY="https://PROXY_SERVER:PORT"
  ```

Or when running from a Docker image (upper and lowercase are needed because of an issue with the Ansible dependency):

  ```bash
  docker run -it -v POSSIBLE_MOUNTS... -e HTTP_PROXY=http://PROXY_SERVER:PORT -e HTTPS_PROXY=http://PROXY_SERVER:PORT http_proxy=http://PROXY_SERVER:PORT -e https_proxy=http://PROXY_SERVER:PORT --rm IMAGE_NAME
  ```

### Note about custom CA certificates

In some cases it might be that a company uses custom CA certificates or CA bundles for providing secure connections. To use these with LambdaStack you can do the following:

#### Devcontainer

Note that for the comments below the filenames of the certificate(s)/bundle do not matter, only the extensions. The certificate(s)/bundle need to be placed here before building the devcontainer.

1. If you have one CA certificate you can add it here with the ```crt``` extension.
2. If you have multiple certificates in a chain/bundle you need to add them here individually with the ```crt``` extension and also add the single bundle with the ```pem``` extension containing the same certificates. This is needed because not all tools inside the container accept the single bundle.

#### LambdaStack release container

If you are running LambdaStack from one of the prebuilt release containers you can do the following to install the certificate(s):

  ```bash
  cp ./path/to/*.crt /usr/local/share/ca-certificates/
  chmod 644 /usr/local/share/ca-certificates/*.crt
  update-ca-certificates
  ```

If you plan to deploy on AWS you also need to add a separate configuration for ```Boto3``` which can either be done by a ```config``` file or setting the ```AWS_CA_BUNDLE``` environment variable. More information about for ```Boto3``` can be found [here.](https://boto3.amazonaws.com/v1/documentation/api/latest/guide/configuration.html)
