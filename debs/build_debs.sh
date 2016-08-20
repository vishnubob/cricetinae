#!/bin/bash
set -e

pushd $(dirname $0) >/dev/null
debdir=$(pwd)
popd >/dev/null

tempdir=$(mktemp -d)
(
    if test -z "$(which git-buildpackage)"; then
        sudo apt-get install git-buildpackage
    fi
    git clone https://github.com/WiringPi/WiringPi.git
    cd WiringPi
    git-buildpackage --git-ignore-new --git-pristine-tar -us -uc --git-export-dir=$tempdir
    mv $tempdir/*.deb $debdir
)
rm -rf $tmpdir
