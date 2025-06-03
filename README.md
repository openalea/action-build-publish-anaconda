# Build and Publish Anaconda Package
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Github Action to build your software package and publish to an Anaconda repository.

This action has been developed for the needs of [`OpenAlea` project](https://openalea.readthedocs.io/en/latest/). It is mostly inspired by existing projects such as [build-and-upload-conda-packages](https://github.com/marketplace/actions/build-and-upload-conda-packages) or [Publish Conda package to Anaconda.org](https://github.com/marketplace/actions/publish-conda-package-to-anaconda-org) and uses [Setup Miniconda](https://github.com/marketplace/actions/setup-miniconda).

In details, this action:
1. Check if `meta.yml` exists in a directory provided in input
2. Sets-up a basic conda environment with a python version specified in input (python 3 only). You can also specify a list of conda channels you migh need during the building process
3. Installs necessary packages for building and publishing (namely `conda-build` and `anaconda-client`)
4. Compiles the package with `conda build` using the `meta.yml` file rules. If your package uses the `numpy` library as a dependency, please be aware that library versions are tied to python version at build time if expressed explicitely in the `meta.yml` file (so far, existing options are `python3.7`:`numpy1.11`, `python3.8`:`numpy1.16`, `python3.9`:`numpy1.19`). Otherwise, `numpy` minor version used at build time can be expressed explicitely in input (cf. bellow).
5. Uploads the package on anaconda.org with `anaconda upload` using a token to access your repository or the one of your organization (cf. procedure [here](#anaconda_token))

The only mandatory input is the anaconda token to access your anaconda repository.

This action is designed to be very generic and the workflow will work even for non pure-python packages.

### Example workflow to build and publish to anaconda every time you make a new release

This example builds your application on multiple plateforms, with multiple python versions. This is a template for your `.github/workflow/build_publish_anaconda.yml` in the [example project structure](#example-project-structure).

```yaml
name: build_publish_anaconda

on:
  push:
    tags:
      - 'v*'
    branches:
      - '**'
  pull_request:
    branches:
      - '**'
  workflow_dispatch: # allows you to trigger manually

jobs:
  build-and-publish:
    name: ${{ matrix.os }}, Python 3.${{ matrix.python-minor-version }} for conda deployment
    runs-on: ${{ matrix.os }}
    strategy:
      fail-fast: false
      max-parallel: 6
      matrix:
        os: [ ubuntu-latest , macos-latest , windows-latest]
        python-minor-version: [9, 10, 11, 12]
        isMaster:
          - ${{ github.ref == 'refs/heads/master' || github.ref == 'refs/heads/main' || startsWith(github.ref, 'refs/tags/v') }}
        exclude:
          - isMaster: false
            python-minor-version: 9
          - isMaster: false
            python-minor-version: 11
          - isMaster: false
            python-minor-version: 12
          - isMaster: false
            os: macos-latest
            python-minor-version: 10
          - isMaster: false
            os: windows-latest
            python-minor-version: 10


    steps:
    - name: Checkout
      uses: actions/checkout@v3
    - name: Determine publish
      uses: haya14busa/action-cond@v1
      id: publish
      with:
        cond: ${{ startsWith(github.ref, 'refs/tags/v') }}
        if_true: 'true'
        if_false: 'false'
    - name: Build and Publish
      uses: openalea/action-build-publish-anaconda@v0.1.4
      with:
        conda: conda
        python: ${{ matrix.python-minor-version }}
        numpy: '22'
        channels: openalea3, conda-forge
        token: ${{ secrets.ANACONDA_TOKEN }}
        publish: ${{ steps.publish.outputs.value }}
        label: main
```

### Example project structure

```
.
├── LICENSE
├── README.md
├── myproject
│   ├── __init__.py
│   └── myproject.py
├── conda
|   ├── bld.bat
│   ├── build.sh
│   └── meta.yaml
├── .github
│   └── workflows
│       └── build_publish_anaconda.yml
├── .gitignore
```

### ANACONDA_TOKEN

This token's purpose is to let your github project access your anaconda repository to publish your package on your channel once it has been successfully built.

1. Get an Anaconda token (don't forget to specify the read and write API access) at `anaconda.org/USERNAME/settings/access` and copy it.
2. Let the github repository of your project access to this token: Add it to the Secrets (`Settings`->`Secrets`->`Actions`->`New repository secret`) of the Github repository as `ANACONDA_TOKEN`

### Actions inputs
The following inputs are available for this action:
| Name | Description | Required | Default value |
|------|-------------|----------|---------------|
|`conda`| Directory with conda recipe (i.e. `meta.yml` file)| No | `conda`|
|`python`| Python3 minor version targeted for build | No | `12` |
|`numpy`| Numpy minor version used for building | No | `''` (fixed by python version)|
|`token` | Anaconda access Token (cf. use process described [above](#anaconda_token))| Yes | |
|`channels`| Optional Extra anaconda channels to use. Coma-separated syntax | No | `conda-forge`|
|`publish`| Wether we publish the package build on anaconda cloud or not | No | 'true' |
|`label` | Label of conda package published | No |`latest`|
|`suffix_if_latest` | Suffix to be added after build_string on latest | No |`_nightly`|
|`promote_from` | Label of Annaconda channel to promote from | No |`rc`|
|`skip_build` | Whether conda build step should be skipped | No |`false`|
|`copy_on_latest` | Whether a co-publication on latest is required | No |`false`|
|`skip_promote` | Whether promotion to label main should be skipped | No |`true`|
|`build-options` | Extra options for conda build | No | `--no-test` |
