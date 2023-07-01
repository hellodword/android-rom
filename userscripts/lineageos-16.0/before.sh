#! /bin/bash

set -eEo pipefail
set -x


cd /android-rom/src/LINEAGE_*/

git config --global --add safe.directory '*'

if [ -f $HOME/patch/art.patch ]
then
    git -C art reset --hard HEAD
    git -C art apply $HOME/patch/art.patch
fi

if [ -f $HOME/patch/build.patch ]
then
    git -C build reset --hard HEAD
    git -C build apply $HOME/patch/build.patch
fi

if [ -f $HOME/patch/base.patch ]
then
    git -C frameworks/base reset --hard HEAD
    git -C frameworks/base apply $HOME/patch/base.patch
fi

if [ -f $HOME/patch/native.patch ]
then
    git -C frameworks/native reset --hard HEAD
    git -C frameworks/native apply $HOME/patch/native.patch
fi


[ "$UNPACK_RAND" = true ] || exit 0
