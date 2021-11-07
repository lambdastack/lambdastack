# Changelog 1.4

## [1.4.0] YYYY-MM-DD

### Added

- Added `lsio` shell script in root directory of repo to easily launch the docker image or pull it down and launch
- Added `build-docker-image.sh` (in .devcontainer) that makes it easier to build a LambdaStack Docker Image. This only stores it in your default local registry on your machine
- Added `push-docker-image-to-registry.sh` (in .devcontainer) to push your LambdaStack image to the LambdaStack Docker Hub public registry. Run `build-docker-image.sh` and then run `push-docker-image-to-registry.sh` to build and push to the public registry
- Added color to the docker image bash shell and made it easier to see

### Fixed

### Updated

- Changed default `use_public_ips: False` to `use_public_ips: True`. This makes it easier to jumpstart and begin learning BUT it creates a security flaw since all IPs should be private and you access to the clusters should be secured via VPN or direct connect
- Changed default yaml config files to be consistent across platforms
- Changed docs to support better Troubleshooting for Kubernetes and easier understanding of LambdaStack and Kubernetes

### Deprecated

### Breaking changes

### Known issues
