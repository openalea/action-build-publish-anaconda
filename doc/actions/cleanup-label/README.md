# cleanup-label

This action:
1. Extract builds from anaconda  channel for a given label
2. Compare build version to version given as input, and remove if build-version < version

The only mandatory input is the anaconda token to access your anaconda repository.

## Example

```yaml
# your_github_workflow.yml
name: MyWorkflow
...
    steps:
    ...
    - name: Cleanup-label
      uses: openalea/action-build-publish-anaconda/cleanup-label@main
      with:
          target-package: astk
          latest-version: 1.2.3
```
## Inputs

<!-- AUTO-DOC-INPUT:START - Do not remove or modify this section -->

|                                   INPUT                                    |  TYPE  | REQUIRED |  DEFAULT  |                                           DESCRIPTION                                           |
|----------------------------------------------------------------------------|--------|----------|-----------|-------------------------------------------------------------------------------------------------|
| <a name="input_anaconda_token"></a>[anaconda_token](#input_anaconda_token) | string |   true   |           |                                Anaconda access Token (required)                                 |
|           <a name="input_dry-run"></a>[dry-run](#input_dry-run)            | string |  false   | `"false"` |                   Dry run only, do not <br>actually clean-up (default false)                    |
| <a name="input_latest-version"></a>[latest-version](#input_latest-version) | string |  false   |           | Latest published version. All inferior <br>version present on target-label will <br>be removed  |
|    <a name="input_target-label"></a>[target-label](#input_target-label)    | string |  false   |  `"dev"`  |                                 Name of the label to <br>clean                                  |
| <a name="input_target-package"></a>[target-package](#input_target-package) | string |  false   |           |                                Name of the package to <br>clean                                 |

<!-- AUTO-DOC-INPUT:END -->

## Outputs

<!-- AUTO-DOC-OUTPUT:START - Do not remove or modify this section -->
No outputs.
<!-- AUTO-DOC-OUTPUT:END -->
