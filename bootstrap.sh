#!/bin/bash
set -e

echo "This is a script you will have to run, once, to bootstrap your build environment"
if test $UID == "0"; then
    echo "You need to run this as yourself, not as root"
    exit -1;
fi

pushd $(dirname $0) >/dev/null
root=$(pwd)
debs=$root/debs
popd >/dev/null

# install our package environment
sudo bash -c \
    "apt-get update;" \
    "apt-get install -y build-essential python-dev python-pip libasound2-dev git-buildpackage swig;" \
    "pip install virtualenv;"

if test ! -e "$debs/wiringpi_2.26~iwj_armhf.deb"; then
    $debs/build_debs.sh
fi

sudo dpkg -i $debs/*.deb
