# android-rom

## lineageos

### lineage 15 & python2

> for bullhead lineage-15.1, `--depth 1` reduces ~50GB (~130GB => ~80GB)

> 可以通过 userscripts 来 patch: begin.sh, before.sh, pre-build.sh, post-build.sh, end.sh

```sh
mkdir -p out/bullhead

sudo rm -rf out/userscripts
cp -r userscripts out/
sudo chown -R root:root "$(pwd)/out/userscripts"
sudo chmod +x "$(pwd)/out/userscripts/lineageos-15.1/before.sh"

sudo rm -rf out/youpk
cp -r youpk out/
sudo chown -R root:root "$(pwd)/out/youpk"
sudo chmod +x "$(pwd)/out/youpk/lineageos-15.1/build.patch.sh"

# 拉取和编译
docker run --rm \
    -e "CUSTOM_REPO_INIT=--depth=1" \
    -e "BRANCH_NAME=lineage-15.1" \
    -e "DEVICE_LIST=bullhead" \
    -e "SIGN_BUILDS=false" \
    -e "SIGNATURE_SPOOFING=no" \
    -e "WITH_GMS=false" \
    -v "$(pwd)/out/userscripts/lineageos-15.1:/root/userscripts:ro" \
    -v "$(pwd)/out/youpk/lineageos-15.1:/root/patch/main:ro" \
    -v "$(pwd)/out/youpk/common:/root/patch/common:ro" \
    -v "$(pwd)/out/bullhead/lineage:/srv/src" \
    -v "$(pwd)/out/bullhead/zips:/srv/zips" \
    -v "$(pwd)/out/bullhead/logs:/srv/logs" \
    -v "$(pwd)/out/bullhead/cache:/srv/ccache" \
    -v "$(pwd)/out/bullhead/keys:/srv/keys" \
    -v "$(pwd)/out/bullhead/manifests:/srv/local_manifests" \
    lineageos4microg/docker-lineage-cicd:python2

# 修改代码后，不拉取，只编译
docker run --rm \
    -e "CUSTOM_REPO_INIT=--depth=1" \
    -e "CUSTOM_REPO_SYNC_DISABLE=true" \
    -e "BRANCH_NAME=lineage-15.1" \
    -e "DEVICE_LIST=bullhead" \
    -e "SIGN_BUILDS=false" \
    -e "SIGNATURE_SPOOFING=no" \
    -e "WITH_GMS=true" \
    -v "$(pwd)/out/userscripts/lineageos-15.1:/root/userscripts:ro" \
    -v "$(pwd)/out/youpk/lineageos-15.1:/root/patch/main:ro" \
    -v "$(pwd)/out/youpk/common:/root/patch/common:ro" \
    -v "$(pwd)/out/bullhead/lineage:/srv/src" \
    -v "$(pwd)/out/bullhead/zips:/srv/zips" \
    -v "$(pwd)/out/bullhead/logs:/srv/logs" \
    -v "$(pwd)/out/bullhead/cache:/srv/ccache" \
    -v "$(pwd)/out/bullhead/keys:/srv/keys" \
    -v "$(pwd)/out/bullhead/manifests:/srv/local_manifests" \
    lineageos4microg/docker-lineage-cicd:python2
```

## Youpk

- https://github.com/Youlor/unpacker/tree/LineageOS-14.1
- https://github.com/Humenger/Youpk8

```sh
git clone --depth=1 -b android-8.0.0_r21 https://android.googlesource.com/platform/art android-8.0.0_r21/art
git clone --depth=1 -b android-8.0.0_r21 https://android.googlesource.com/platform/build android-8.0.0_r21/build
git clone --depth=1 -b android-8.0.0_r21 https://android.googlesource.com/platform/frameworks/base android-8.0.0_r21/frameworks/base
git clone --depth=1 -b android-8.0.0_r21 https://android.googlesource.com/platform/frameworks/native android-8.0.0_r21/frameworks/native

git clone --depth=1 https://github.com/Humenger/Youpk8
rsync -a Youpk8/android-8.0.0_r21/art/ android-8.0.0_r21/art
mv Youpk8/android-8.0.0_r21/build/make/core/tasks/check_boot_jars/package_whitelist.txt android-8.0.0_r21/build/core/tasks/check_boot_jars/package_whitelist.txt
rsync -a Youpk8/android-8.0.0_r21/frameworks/base/ android-8.0.0_r21/frameworks/base
rsync -a Youpk8/android-8.0.0_r21/frameworks/native/ android-8.0.0_r21/frameworks/native

mkdir -p youpk/android-8.0.0_r21
find android-8.0.0_r21 -name .git | xargs -L 1 dirname | xargs -I '{}' bash -c 'git -C "{}" config user.email "example@android.com" && git -C "{}" config user.name android && git -C "{}" add . && git -C "{}" commit -m diff && git -C "{}" diff HEAD~1 > youpk/android-8.0.0_r21/$(basename "{}").patch'
```


## reproducible

- https://www.reddit.com/r/LineageOS/comments/9bqlze/why_make_lineageos_builds_with_zero_changes/

---

- https://wiki.lineageos.org/devices/bullhead/
- https://github.com/lineageos4microg/docker-lineage-cicd
- https://github.com/julianxhokaxhiu/docker-lineage-cicd
- https://github.com/jfloff/docker-lineageos
