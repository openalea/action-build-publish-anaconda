#!/bin/bash

set -ex
set -o pipefail

go_to_build_dir() {
    if [ ! -z $INPUT_SUBDIR ]; then
        cd $INPUT_SUBDIR
    fi
}

check_if_meta_yaml_file_exists() {
    if [ ! -f meta.yaml ]; then
        echo "meta.yaml must exist in the directory that is being packaged and published."
        exit 1
    fi
}

build_package(){
    conda build -c conda-forge --output-folder . .
}

upload_package(){
    export ANACONDA_API_TOKEN=$INPUT_ANACONDATOKEN
    anaconda upload --label main --all linux-64/*.tar.bz2
}

go_to_build_dir
check_if_meta_yaml_file_exists
build_package
upload_package
