# build_publish_promote

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A reusable Github workflow to build your software package and publish to an Anaconda repository following openalea guidelines.

## Usage

### Build and publish according to openalea guidelines

Copy the template below in your source dir, using the following path: `.github/workflow/build_publish_anaconda.yml`.


```yaml
# your_package/.github/workflow/build_publish_anaconda.yml

name: Building Package after Openalea guidelines

on:
  push:
    branches:
      - '**'
    tags:
      - 'v*'
  pull_request:
    branches:
      - '**'
  release:

# avoid duplicating jobs
concurrency:
  group: ${{ github.workflow }}-${{ github.head_ref || github.ref }}
  cancel-in-progress: true

jobs:
  build:
    uses: openalea/action-build-publish-anaconda/.github/workflows/build_publish_promote.yml@main
    secrets:
      anaconda_token: ${{ secrets.ANACONDA_TOKEN }}
```
Note that to publish your package to your anaconda channel, you must meet one of the following conditions :
- push on master. This will trigger an upload on the 'dev' label.
- have a tag that defines a new version of your package : `v...`. This allows uploading a new version of the package on the `rc` anaconda channel
- create a release. This will promote your package to 'main'. This action is part of OpenAlea Release collective process: do not use except invited by Openalea developpers.

You can customize the workflow with different inputs (see below).
For example, if you want to run without launching test on `ubuntu-latest` and `macos-latest`, `python 3.10` only, then your workflow file would look like this:

```yaml


name: build_publish_anaconda

...

jobs:
  build:
    uses: openalea/action-build-publish-anaconda/.github/workflows/build_publish_promote.yml@main
    secrets:
      anaconda_token: ${{ secrets.ANACONDA_TOKEN }}
    with:
      python-minor-version: "[ 10 ]"
      operating-system: '["ubuntu-latest", "macos-latest"]'
      build-options: "--no-test"
```

## Inputs