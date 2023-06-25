#! /bin/bash

set -eEuo pipefail
set -x


cd /srv/src/LINEAGE_15_1/

rsync -a /root/patch/common/ .

git config --global --add safe.directory '*'

git -C art reset --hard HEAD
git -C art apply /root/patch/main/art.patch

/root/patch/main/build.patch.sh

git -C frameworks/base reset --hard HEAD
git -C frameworks/base apply /root/patch/main/base.patch

git -C frameworks/native reset --hard HEAD
git -C frameworks/native apply /root/patch/main/native.patch
