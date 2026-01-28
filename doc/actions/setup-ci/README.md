# setup-ci

This action:
1. Check if 'meta.yaml' exists, if package is 'noarch' (i.e. "pure python"), if it allows external version setting, has build string and 
2. Detect calling context and set contextual flags (is_master, is_branch, is_release...)
3. Set OS × Python matrix array depending on context and noarch
4. Set publication variables depending on event (publish, promote...)
5. Set conda channels in priority order depending on event (dev, rc, main)
6. Detect package version based on context and git v* tags (1.1.0, 1.1.1.dev)

The only mandatory input is the anaconda token to access your anaconda repository.

## Example

```yaml
# your_github_workflow.yml
name: MyWorkflow
...
    steps:
    ...
    - name: Setup-CI
      uses: openalea/action-build-publish-anaconda/setup-ci@main
      with:
          git-ref: github.ref
          git-event: github.event_name
```

## Inputs

<!-- AUTO-DOC-INPUT:START - Do not remove or modify this section -->

|                                               INPUT                                                |  TYPE  | REQUIRED |                                      DEFAULT                                      |                                                                                     DESCRIPTION                                                                                      |
|----------------------------------------------------------------------------------------------------|--------|----------|-----------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|           <a name="input_conda-directory"></a>[conda-directory](#input_conda-directory)            | string |  false   |                                     `"conda"`                                     |                                                           Directory containing the conda recipe. <br>Default is "conda".                                                             |
|                    <a name="input_dev-label"></a>[dev-label](#input_dev-label)                     | string |  false   |                                      `"dev"`                                      |                                            The label used for publishing <br>development versions (latest version of master/main branch)                                             |
| <a name="input_force-channel-priority"></a>[force-channel-priority](#input_force-channel-priority) | string |  false   |                                     `"false"`                                     | Force channels priority used for <br>build (coma separated format), regardless of context. <br>If false (default), priority list <br>is computed by action depending <br>on context  |
|        <a name="input_force-full-matrix"></a>[force-full-matrix](#input_force-full-matrix)         | string |  false   |                                     `"false"`                                     |                                                                       Force build on full os <br>x py matrix.                                                                        |
|             <a name="input_force-no-clean"></a>[force-no-clean](#input_force-no-clean)             | string |  false   |                                     `"false"`                                     |                                                           Prevent cleaning (forbid action to clean anything on anaconda)                                                             |
|    <a name="input_force-no-publication"></a>[force-no-publication](#input_force-no-publication)    | string |  false   |                                     `"false"`                                     |                                                         Prevent publication (forbid action to publish anything on anaconda)                                                          |
|        <a name="input_force-ubuntu-only"></a>[force-ubuntu-only](#input_force-ubuntu-only)         | string |  false   |                                     `"false"`                                     |                                                                              Force build on ubuntu only                                                                              |
|                    <a name="input_git-event"></a>[git-event](#input_git-event)                     | string |  false   |                                                                                   |                The name of the event <br>that triggered the workflow (eg push, pull-request...).In <br>the context of calling workflow, <br>github.event_name value                  |
|                       <a name="input_git-ref"></a>[git-ref](#input_git-ref)                        | string |  false   |                                                                                   |                        The Git reference that triggered <br>the workflow (eg refs/heads/main). In the <br>context of calling workflow, github.ref <br>value                          |
|          <a name="input_operating-system"></a>[operating-system](#input_operating-system)          | string |  false   | `"[\"ubuntu-latest\", \"macos-latest\", \"macos-15-intel\", \"windows-latest\"]"` |                                                                            List of OS covered by <br>CI.                                                                             |
|                <a name="input_organisation"></a>[organisation](#input_organisation)                | string |  false   |                     `"https://conda.anaconda.org/openalea3"`                      |                                                              Channel of the organisation hosting <br>the publications                                                                |
|    <a name="input_python-minor-version"></a>[python-minor-version](#input_python-minor-version)    | string |  false   |                                                                                   |                                          List of python minor versions <br>covered by CI. Leave empty <br>to auto-fetch from conda-forge.                                            |
|                      <a name="input_rc-label"></a>[rc-label](#input_rc-label)                      | string |  false   |                                      `"rc"`                                       |                                                    The label used for publishing <br>release candidates versions (latest v* tag)                                                     |

<!-- AUTO-DOC-INPUT:END -->

## Outputs

<!-- AUTO-DOC-OUTPUT:START - Do not remove or modify this section -->

|                                     OUTPUT                                      |  TYPE  |                                                             DESCRIPTION                                                              |
|---------------------------------------------------------------------------------|--------|--------------------------------------------------------------------------------------------------------------------------------------|
|           <a name="output_build_os"></a>[build_os](#output_build_os)            | string |                                                       Selected OS to build on                                                        |
|           <a name="output_build_py"></a>[build_py](#output_build_py)            | string |                                           Selected Python minor versions to <br>build on                                             |
|           <a name="output_channels"></a>[channels](#output_channels)            | string | A comma separated string of <br>channels to pick-up packages during <br>builds. Channel priority is strict: <br>first is used first  |
|                <a name="output_clean"></a>[clean](#output_clean)                | string |                                                     True if cleaning is required                                                     |
|       <a name="output_clean-label"></a>[clean-label](#output_clean-label)       | string |                                                            label to clean                                                            |
|     <a name="output_package_name"></a>[package_name](#output_package_name)      | string |                                                             package name                                                             |
|             <a name="output_publish"></a>[publish](#output_publish)             | string |                                                   True if publication is required                                                    |
|    <a name="output_publish_if_os"></a>[publish_if_os](#output_publish_if_os)    | string |               Publish only if build_os belongs <br>to this list of os. <br>Use empty list ([]) to <br>pass this test.                |
|    <a name="output_publish_if_py"></a>[publish_if_py](#output_publish_if_py)    | string |      Publish only if build_py belongs <br>to this list of python <br>minor versions. Use empty list <br>([]) to pass this test       |
|        <a name="output_publish_to"></a>[publish_to](#output_publish_to)         | string |                                                         label to publish to                                                          |
|          <a name="output_py_latest"></a>[py_latest](#output_py_latest)          | string |                                               latest python version covered by <br>CI                                                |
| <a name="output_upload_artifact"></a>[upload_artifact](#output_upload_artifact) | string |                                            True if build artifact should <br>be uploaded                                             |
|             <a name="output_version"></a>[version](#output_version)             | string |                                                           package version                                                            |

<!-- AUTO-DOC-OUTPUT:END -->