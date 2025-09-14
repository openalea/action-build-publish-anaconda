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

## Outputs
