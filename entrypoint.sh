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
    conda build --output-folder . .
    conda convert -p osx-64 linux-64/*.tar.bz2
}

upload_package(){
    anaconda login --username $INPUT_ANACONDAUSERNAME --password $INPUT_ANACONDAPASSWORD
    anaconda upload linux-64/*.tar.bz2
    anaconda upload osx-64/*.tar.bz2
    anaconda logout
}

go_to_build_dir
check_if_meta_yaml_file_exists
build_package
upload_package
