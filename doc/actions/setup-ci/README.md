<!-- BEGIN_ACTION_DOCS -->

# setup-ci
Setup CI variables according to calling context

# inputs
| Title | Required | Type | Default| Description |
|-----|-----|-----|-----|-----|
| git-ref | False |  |  | github.ref context of calling workflow |
| git-event | False |  |  | github.event_name context of calling workflow |
| conda-directory | False |  | `conda` | Directory containing the conda recipe. Default is "conda". |
| python-minor-version | False |  | `[9, 10, 11, 12]` | List of python minor versions to build/deploy the package. |
| operating-system | False |  | `["ubuntu-latest", "macos-latest", "macos-13", "windows-latest"]` | List of OS for build/deploy. |
| organisation | False |  | `https://conda.anaconda.org/openalea3` | Channel of the organisation hosting the publications |
| dev-label | False |  | `dev` | The label used for publishing development versions (latest version of master/main branch) |
| rc-label | False |  | `rc` | The label used for publishing release candidates versions (latest v* tag) |
| force-channel-priority | False |  | `false` | Force channels priority used for build (coma separated format), regardless of context. If false (default), priority list is computed by action depending on context |
| force-build-matrix | False |  | `false` | Force full input matrix builds regardless of context. |
| force-skip-publish | False |  | `false` | Force skipping publication. |
| force-skip-promotion | False |  | `false` | Force skipping promotion. |

# outputs
| Title | Description | Value |
|-----|-----|-----|
|build_os | Selected OS to build on |  `${{ steps.set-matrix.outputs.build_os }}` | 
|build_py | Selected Python minor versions to build on |  `${{ steps.set-matrix.outputs.build_py }}` | 
|build_options | Build options for conda build |  `${{ steps.set-matrix.outputs.build_options }}` | 
|publish | True if publication is required |  `${{ steps.set-pub.outputs.publish }}` | 
|promote | True if promotion only is required |  `${{ steps.set-pub.outputs.promote }}` | 
|channels | A comma separated string of channels to pick-up packages during builds. Channel priority is strict: first is used first |  `${{ steps.set-channel.outputs.channels }}` | 
|publish_on | label to publish on |  `${{ steps.set-pub.outputs.publish_on }}` | 
|promote_from | label to promote from |  `${{ steps.set-pub.outputs.promote_from }}` | 
|promote_to | label to promote to |  `${{ steps.set-pub.outputs.promote_to }}` | 
|version | package version |  `${{ steps.setv.outputs.version }}` | 
<!-- END_ACTION_DOCS -->