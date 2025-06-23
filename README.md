# A reusable CI workflow to Build and Publish Openalea Packages
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A collection of Github Actions to build your software package and publish to an Anaconda repository.

These actions have been developed for the needs of [`OpenAlea` project](https://openalea.readthedocs.io/en/latest/). It is mostly inspired by existing projects such as [build-and-upload-conda-packages](https://github.com/marketplace/actions/build-and-upload-conda-packages) or [Publish Conda package to Anaconda.org](https://github.com/marketplace/actions/publish-conda-package-to-anaconda-org) and uses [Setup Miniconda](https://github.com/marketplace/actions/setup-miniconda).

The main openalea workflow using these actions can be found [here](https://github.com/openalea/github-action-conda-build/tree/main/.github/workflows)

It allows trigerring different CI jobs, depending on the context, as illustrated on the figure:


![Build Flow](images/CI_workflow.png)

## Contents

- [SetUp](./setup-ci/README.md)
- [BuildAndPublish](./build_and_publish/README.md)
- 


