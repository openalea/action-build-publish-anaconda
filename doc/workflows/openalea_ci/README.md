# openalea_ci

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A reusable Github workflow to build your software package and publish to an Anaconda repository following openalea guidelines.

## Usage

### Prerequisites

OpenAlea CI workflow requires that your package includes the following lines in its `meta.yaml` recipe:

```yaml
{% set version = environ.get('SETUPTOOLS_SCM_PRETEND_VERSION', "0.0.0.dev") %}

...
package:
  ...
  version: {{ version }}

...

build:
  ...
  string: py{{ PY_VER }}
```

If your package is a pure Python package, we also recommend to decalare it :

```yaml
...
build:
  noarch: python
...
```


### Activate OpenAlea_CI on your package

From your github repo, online : 
- Open 'Actions' tab 
- click 'new workflow'. 
- Scroll down and select 'by Openalea / openalea CI workflow'
- Commit 

Or, using git, add the following template in your source dir, using the following path: `.github/workflows/openalea_ci.yml`.


```yaml
# your_package/.github/workflows/openalea_ci.yml

name: OpenAlea CI

on:
  push:
    branches:
      - main
      - master
    tags:
      - 'v*'
  pull_request:
    types:
      - opened
      - synchronize
      - reopened
  release:
    types:
      - published

jobs:
  build:
    uses: openalea/action-build-publish-anaconda/.github/workflows/openalea_ci.yml@main
    secrets:
      anaconda_token: ${{ secrets.ANACONDA_TOKEN }}
```
Note that to publish your package to your anaconda channel, you must meet one of the following conditions :
- push or merge PR on master. This will trigger an upload on the 'dev' label.
- push a tag starting with 'v' that defines a new version of your package. This will trigger uploading on the `rc` label.
- create a release from Github UI. This will promote your package to 'main'. This action is part of OpenAlea Release collective process: do not use except invited by Openalea developpers.

### (optional) Customize your action

You can customize the workflow with different inputs to make test or escape CI rules for a while.
For example, if you want to run CI only on push on branches without launching test nor publishing or promoting anything, but just trigger conda build on `ubuntu-latest` and `macos-latest`, `python 3.10` only, then your workflow file would look like this:

```yaml


name: My custom CI

on:
  push:
    branches:
      - '**'

jobs:
  build:
    uses: openalea/action-build-publish-anaconda/.github/workflows/openalea_ci.yml@main
    secrets:
      anaconda_token: ${{ secrets.ANACONDA_TOKEN }}
    with:
      python-minor-version: "[ 10 ]"
      operating-system: '["ubuntu-latest", "macos-latest"]'
      force-build-matrix: "true"
      build-options: "--no-test"
      force-skip-publish: "true"
      force-skip-promotion: "true"


```

## Inputs

<!-- AUTO-DOC-INPUT:START - Do not remove or modify this section -->

|                                               INPUT                                                |  TYPE   | REQUIRED |                                   DEFAULT                                   |                                                                                     DESCRIPTION                                                                                      |
|----------------------------------------------------------------------------------------------------|---------|----------|-----------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|              <a name="input_build-options"></a>[build-options](#input_build-options)               | string  |  false   |                                                                             |                                                                            Build options for conda build.                                                                            |
|           <a name="input_conda-directory"></a>[conda-directory](#input_conda-directory)            | string  |  false   |                                  `"conda"`                                  |                                                           Directory containing the conda recipe. <br>Default is "conda".                                                             |
|                    <a name="input_dev-label"></a>[dev-label](#input_dev-label)                     | string  |  false   |                                   `"dev"`                                   |                                            The label used for publishing <br>development versions (latest version of master/main branch)                                             |
|       <a name="input_force-build-matrix"></a>[force-build-matrix](#input_force-build-matrix)       | boolean |  false   |                                   `false`                                   |                                                              Force full input matrix builds <br>regardless of context.                                                               |
| <a name="input_force-channel-priority"></a>[force-channel-priority](#input_force-channel-priority) | string  |  false   |                                  `"false"`                                  | Force channels priority used for <br>build (coma separated format), regardless of context. <br>If false (default), priority list <br>is computed by action depending <br>on context  |
|    <a name="input_force-skip-promotion"></a>[force-skip-promotion](#input_force-skip-promotion)    | boolean |  false   |                                   `false`                                   |                                                     Force skipping publication (forbid action to publish anything on anaconda)                                                       |
|       <a name="input_force-skip-publish"></a>[force-skip-publish](#input_force-skip-publish)       | boolean |  false   |                                   `false`                                   |                                                  Force skipping promotion (forbid action to change label of packages on anaconda)                                                    |
|          <a name="input_operating-system"></a>[operating-system](#input_operating-system)          | string  |  false   | `"[\"ubuntu-latest\", \"macos-latest\", \"macos-13\", \"windows-latest\"]"` |                                                                             List of OS for build/deploy.                                                                             |
|                <a name="input_organisation"></a>[organisation](#input_organisation)                | string  |  false   |                  `"https://conda.anaconda.org/openalea3"`                   |                                                              Channel of the organisation hosting <br>the publications                                                                |
|    <a name="input_python-minor-version"></a>[python-minor-version](#input_python-minor-version)    | string  |  false   |                             `"[9, 10, 11, 12]"`                             |                                                           List of python minor versions <br>to build/deploy the package.                                                             |
|                      <a name="input_rc-label"></a>[rc-label](#input_rc-label)                      | string  |  false   |                                   `"rc"`                                    |                                                    The label used for publishing <br>release candidates versions (latest v* tag)                                                     |

<!-- AUTO-DOC-INPUT:END -->