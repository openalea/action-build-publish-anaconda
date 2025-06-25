# generate documentation of action


This action uses [auto-doc](https://github.com/tj-actions/auto-doc) to generate inputs and outputs formatted table from action code.

In the targeted README.md, the ## Inputs and ## Outputs section will be replaced by a auto-generated table.

## usage

This workflow can be mannually called from Actions tag of the Github Repos. It will update the doc (if needed) and open a pull request for changes. 