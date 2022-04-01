# Build and Publish Anaconda Package

A Github Action to build publish your software package to an Anaconda repository.

### Example workflow to publish to conda every time you make a new release

```yaml
name: publish_conda

on:
  release:
    types: [published]
    
jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: publish-to-conda
      uses: thomasarsouze/build-and-publish-anaconda@v1
      with:
        condaDir: 'conda'
        pythonVersion: 3.9
        anacondaToken: ${{ secrets.ANACONDA_TOKEN }}
        channels: conda-forge, openalea
        publishChannel: openalea
```

### Example project structure

```
.
├── LICENSE
├── README.md
├── myproject
│   ├── __init__.py
│   └── myproject.py
├── conda
│   ├── build.sh
│   └── meta.yaml
├── .github
│   └── workflows
│       └── publish_conda.yml
├── .gitignore
```

### ANACONDA_TOKEN

1. Get an Anaconda token (with read and write API access) at `anaconda.org/USERNAME/settings/access` 
2. Add it to the Secrets of the Github repository as `ANACONDA_TOKEN`

### Actions inputs
`condaBuildDir`: Directory with conda recipe. Default `.`.

`pythonVersion`: Python version used for building. Defaults 3.9

`anacondaToken`: Anaconda access Token. Required.

`channels`: Optional Extra anaconda channels to use. Default conda-forge.

`publishChannel`: Optional Channel to publish the anaconda package. Default conda-forge.