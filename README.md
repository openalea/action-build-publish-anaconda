# Publish Anaconda Package
A Github Action to publish your Python package to Anaconda repository.

### Example workflow

```yaml
name: publish_conda

on: [release]

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: publish-to-conda
      uses: maxibor/conda-package-publish-action@master
      with:
        subDir: 'conda'
        AnacondaToken: ${{ secrets.ANACONDA_TOKEN }}
```
Get an Anaconda token (with read and write API access) at anaconda.org/username/settings/access and add it to the Secrets of the Github repository as `ANACONDA_TOKEN`