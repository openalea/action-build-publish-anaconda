#!/bin/bash

set -ex
set -o pipefail

go_to_build_dir() {
    if [ ! -z $INPUT_CONDADIR ]; then
        cd $INPUT_CONDADIR
    fi
}

check_if_meta_yaml_file_exists() {
    if [ ! -f meta.yaml ]; then
        echo "meta.yaml must exist in the directory that is being packaged and published."
        exit 1
    fi
}

build_package(){
    IFS=','; read -a arr_channels<<<"$INPUT_CHANNELS"; unset IFS;
    channels=""; for c in "${arr_channels[@]}"; do channels+="-c $c "; done
    conda build ${channels} --python=$INPUT_PYTHONVERSION --output-folder . .
}

upload_package(){
    export ANACONDA_API_TOKEN=$INPUT_ANACONDATOKEN
    anaconda upload --skip-existing --no-progress -u $INPUT_PUBLISHCHANNEL
}

go_to_build_dir
check_if_meta_yaml_file_exists
build_package
upload_package
