# A reusable CI workflow to Build and Publish Openalea Packages
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This repo host a collection of Github Actions and reusable workflows to build your Python software package and publish to an Anaconda repository.

The main workflow and the instructions for using this CI on your package can be found [here](./doc/workflows/openalea_ci/README.md)

These actions have been developed for the needs of [`OpenAlea` project](https://openalea.readthedocs.io/en/latest/). It is mostly inspired by existing projects such as [build-and-upload-conda-packages](https://github.com/marketplace/actions/build-and-upload-conda-packages) or [Publish Conda package to Anaconda.org](https://github.com/marketplace/actions/publish-conda-package-to-anaconda-org) and uses [Setup Miniconda](https://github.com/marketplace/actions/setup-miniconda).

It allows trigerring different CI jobs, depending on the context:


![Build Flow](images/CI_workflow.png)

Note the the `(ALL)` in the `CI Build` column means that this job is triggered for all OS platforms only for non pure-Python packages, otherwise it is only triggered for `linux`.

## Documentation

### Actions
- [setup-ci](./doc/actions/setup-ci/README.md) : preliminary computation of inputs and environment variables to the `builkd-publish-anaconda` action as a function of the context (branch, tag, pull request, etc.).
- [build-publish-anaconda](./doc/actions/build_and_publish/README.md) : main action that actually builds the conda package and publishes it to an Anaconda repository.

### Workflows
- [openalea_ci](./doc/workflows/openalea_ci/README.md) : main workflow that is meant to be used in your package. It combines the `setup-ci` and `build-publish-anaconda` actions.

- [test_setup](./doc/workflows/test_setup/README.md) : for testing the `setup-ci` action in different simulated contexts.
- [test_dummy](./doc/workflows/test_dummy/README.md) : test the chaining of `setup-ci` and `build-publish-anaconda` actions on two dummy packages : one pure Python and one non pure Python.
- [generate_docs](./doc/workflows/generate_docs/README.md) : internal workflow that creates a PR to update the documentation of the actions and workflows in this repository.
