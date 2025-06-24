# setup-ci

This action:
1. Check if 'meta.yaml' exists and allows external version setting
2. Detect calling context and set contextual flags (is_master, is_branch, is_release...)
3. Set OS × Python matrix array depending on event
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

## Outputs