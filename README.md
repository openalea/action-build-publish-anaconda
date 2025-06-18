## Build and Publish Anaconda Package
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A collection of Github Actions to build your software package and publish to an Anaconda repository.

These actions have been developed for the needs of [`OpenAlea` project](https://openalea.readthedocs.io/en/latest/). It is mostly inspired by existing projects such as [build-and-upload-conda-packages](https://github.com/marketplace/actions/build-and-upload-conda-packages) or [Publish Conda package to Anaconda.org](https://github.com/marketplace/actions/publish-conda-package-to-anaconda-org) and uses [Setup Miniconda](https://github.com/marketplace/actions/setup-miniconda).

The main openalea workflow using these actions can be found [here](https://github.com/openalea/github-action-conda-build/tree/main/.github/workflows)

The different actions are :

## build_and_publish/action.yml

This action:
1. Check if `meta.yml` exists in a directory provided in input
2. Sets-up a basic conda environment with a python version specified in input (python 3 only). You can also specify a list of conda channels you migh need during the building process
3. Installs necessary packages for building and publishing (namely `conda-build` and `anaconda-client`)
4. Compiles the package with `conda build` using the `meta.yml` file rules. If your package uses the `numpy` library as a dependency, please be aware that library versions are tied to python version at build time if expressed explicitely in the `meta.yml` file (so far, existing options are `python3.7`:`numpy1.11`, `python3.8`:`numpy1.16`, `python3.9`:`numpy1.19`). Otherwise, `numpy` minor version used at build time can be expressed explicitely in input (cf. bellow).
5. Uploads the package on anaconda.org with `anaconda upload` using a token to access your repository or the one of your organization (cf. procedure [here](#anaconda_token))

The only mandatory input is the anaconda token to access your anaconda repository.

This action is designed to be very generic and the workflow will work even for non pure-python packages.

### Example

```yaml
# your_github_workflow.yml
name: MyWorkflow
...
    steps:
	...
    - name: Build and Publish
      uses: openalea/action-build-publish-anaconda/build_and_publish@main
      with:
        numpy: '22'
        channels: 'openalea3,conda-forge'
        label: 'main'
```

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
|`suffix` | Suffix to be added in build_string | No |``|
|`build-options` | Extra options for conda build | No | `--no-test` |


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



