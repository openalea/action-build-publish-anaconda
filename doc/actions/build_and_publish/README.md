# build_and_publish

This action:
1. Check if `meta.yml` exists in a directory provided in input
2. Sets-up a basic conda environment with a python version specified in input (python 3 only). You can also specify a list of conda channels you migh need during the building process
3. Installs necessary packages for building and publishing (namely `conda-build` and `anaconda-client`)
4. Compiles the package with `conda build` using the `meta.yml` file rules. If your package uses the `numpy` library as a dependency, please be aware that library versions are tied to python version at build time if expressed explicitely in the `meta.yml` file (so far, existing options are `python3.7`:`numpy1.11`, `python3.8`:`numpy1.16`, `python3.9`:`numpy1.19`). Otherwise, `numpy` minor version used at build time can be expressed explicitely in input (cf. bellow).
5. Uploads the package on anaconda.org with `anaconda upload` using a token to access your repository or the one of your organization (cf. procedure [here](#anaconda_token))

The only mandatory input is the anaconda token to access your anaconda repository.

This action is designed to be very generic and the workflow will work even for non pure-python packages.

## Example

```yaml
# your_github_workflow.yml
name: MyWorkflow
...
    steps:
    ...
    - name: Build and Publish
      uses: openalea/action-build-publish-anaconda/build_and_publish@main
      with:
        token: ${{ secrets.ANACONDA_TOKEN }}
        channels: 'openalea3,conda-forge'
        label: 'main'
```

## Inputs

<!-- AUTO-DOC-INPUT:START - Do not remove or modify this section -->

|                                     INPUT                                     |  TYPE  | REQUIRED |     DEFAULT     |                                                   DESCRIPTION                                                    |
|-------------------------------------------------------------------------------|--------|----------|-----------------|------------------------------------------------------------------------------------------------------------------|
|    <a name="input_build-options"></a>[build-options](#input_build-options)    | string |  false   |                 |                                          Build options for conda build.                                          |
|           <a name="input_channels"></a>[channels](#input_channels)            | string |  false   | `"conda-forge"` |           Optional Extra anaconda channels to <br>use. Coma-separated syntax. Default `conda-forge`.             |
|                <a name="input_conda"></a>[conda](#input_conda)                | string |  false   |      `"."`      |                                 Directory with conda recipe. Default <br>`.` .                                   |
|       <a name="input_condapython"></a>[condapython](#input_condapython)       | string |  false   |     `"12"`      |                                    Python3 minor version used for <br>conda.                                     |
|                <a name="input_label"></a>[label](#input_label)                | string |  false   |    `"main"`     |                                         Label of conda package published                                         |
|             <a name="input_os_name"></a>[os_name](#input_os_name)             | string |  false   |   `"unknown"`   |                      The name of the os <br>the action is called on <br>(eg ubuntu-latest)                       |
|             <a name="input_publish"></a>[publish](#input_publish)             | string |  false   |    `"true"`     |                     Whether we publish the package <br>build on anaconda cloud or <br>not.                       |
| <a name="input_publish_only_on"></a>[publish_only_on](#input_publish_only_on) | string |  false   |                 | Restrict publishing to a specific <br>OS (e.g., ubuntu-latest). Leave blank to <br>publish without restriction.  |
|              <a name="input_python"></a>[python](#input_python)               | string |  false   |     `"12"`      |                                  Python3 minor version used for <br>building.                                    |
|                <a name="input_token"></a>[token](#input_token)                | string |   true   |                 |                                         Anaconda access Token (required)                                         |

<!-- AUTO-DOC-INPUT:END -->

## ANACONDA_TOKEN

This token's purpose is to let your github project access your anaconda repository to publish your package on your channel once it has been successfully built.

1. Get an Anaconda token (don't forget to specify the read and write API access) at `anaconda.org/USERNAME/settings/access` and copy it.
2. Let the github repository of your project access to this token: Add it to the Secrets (`Settings`->`Secrets`->`Actions`->`New repository secret`) of the Github repository as `ANACONDA_TOKEN`
