#! /bin/bash

set -eEuo pipefail
set -x


cd /srv/src/LINEAGE_15_1/

rsync -a /root/patch/common/ .

git config --global --add safe.directory '*'

if [ -f /root/patch/main/art.patch ]
then
    git -C art reset --hard HEAD
    git -C art apply /root/patch/main/art.patch
fi

if [ -f /root/patch/main/build.patch ]
then
    git -C build reset --hard HEAD
    git -C build apply /root/patch/main/build.patch
fi

if [ -f /root/patch/main/build.patch.sh ]
then
    /root/patch/main/build.patch.sh
fi

if [ -f /root/patch/main/base.patch ]
then
    git -C frameworks/base reset --hard HEAD
    git -C frameworks/base apply /root/patch/main/base.patch
fi

if [ -f /root/patch/main/native.patch ]
then
    git -C frameworks/native reset --hard HEAD
    git -C frameworks/native apply /root/patch/main/native.patch
fi

# randomize
