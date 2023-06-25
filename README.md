# android-rom

## build lineageos with docker

> for bullhead lineage-15.1, `--depth=1` reduces ~50GB (~130GB => ~80GB)

### lineage-15.1 (8.1.0)

```sh
mkdir -p out/lineage-15.1

# 同步和编译，禁用 microg 的 patch
docker run --rm \
    -e "REPO_INIT_ARGS=--depth=1" \
    -e "BRANCH_NAME=lineage-15.1" \
    -e "DEVICE_LIST=bullhead" \
    -e "SIGN_BUILDS=false" \
    -e "SIGNATURE_SPOOFING=no" \
    -e "WITH_GMS=false" \
    -e "CLEAN_AFTER_BUILD=false" \
    -e "USE_PYTHON2=true" \
    -e "USE_GCC9=true" \
    -v "$(pwd)/out/lineage-15.1/lineage:/srv/src" \
    -v "$(pwd)/out/lineage-15.1/zips:/srv/zips" \
    -v "$(pwd)/out/lineage-15.1/logs:/srv/logs" \
    -v "$(pwd)/out/lineage-15.1/cache:/srv/ccache" \
    -v "$(pwd)/out/lineage-15.1/keys:/srv/keys" \
    -v "$(pwd)/out/lineage-15.1/manifests:/srv/local_manifests" \
    ghcr.io/hellodword/docker-lineage-cicd:dev2023

# 修改代码后，不同步，只编译
docker run --rm \
    -e "REPO_SYNC=false" \
    -e "REPO_INIT=false" \
    -e "UPDATE_PROPRIETARY=false" \
    -e "ENABLE_GIT_RESET=false" \
    -e "ENABLE_GIT_CLEAN=false" \
    -e "BRANCH_NAME=lineage-15.1" \
    -e "DEVICE_LIST=bullhead" \
    -e "SIGN_BUILDS=false" \
    -e "SIGNATURE_SPOOFING=no" \
    -e "WITH_GMS=false" \
    -e "CLEAN_AFTER_BUILD=false" \
    -e "USE_PYTHON2=true" \
    -e "USE_GCC9=true" \
    -v "$(pwd)/out/lineage-15.1/lineage:/srv/src" \
    -v "$(pwd)/out/lineage-15.1/zips:/srv/zips" \
    -v "$(pwd)/out/lineage-15.1/logs:/srv/logs" \
    -v "$(pwd)/out/lineage-15.1/cache:/srv/ccache" \
    -v "$(pwd)/out/lineage-15.1/keys:/srv/keys" \
    -v "$(pwd)/out/lineage-15.1/manifests:/srv/local_manifests" \
    ghcr.io/hellodword/docker-lineage-cicd:dev2023
```

### lineage-16.0 (9.0.0)

```sh
mkdir -p out/lineage-16.0

# 同步和编译，禁用 microg 的 patch
docker run --rm \
    -e "REPO_INIT_ARGS=--depth=1" \
    -e "BRANCH_NAME=lineage-16.0" \
    -e "DEVICE_LIST=dipper" \
    -e "SIGN_BUILDS=false" \
    -e "SIGNATURE_SPOOFING=no" \
    -e "WITH_GMS=false" \
    -e "CLEAN_AFTER_BUILD=false" \
    -e "USE_PYTHON2=true" \
    -e "USE_GCC9=true" \
    -v "$(pwd)/out/lineage-16.0/lineage:/srv/src" \
    -v "$(pwd)/out/lineage-16.0/zips:/srv/zips" \
    -v "$(pwd)/out/lineage-16.0/logs:/srv/logs" \
    -v "$(pwd)/out/lineage-16.0/cache:/srv/ccache" \
    -v "$(pwd)/out/lineage-16.0/keys:/srv/keys" \
    -v "$(pwd)/out/lineage-16.0/manifests:/srv/local_manifests" \
    ghcr.io/hellodword/docker-lineage-cicd:dev2023

# 修改代码后，不同步，只编译
docker run --rm \
    -e "REPO_SYNC=false" \
    -e "REPO_INIT=false" \
    -e "UPDATE_PROPRIETARY=false" \
    -e "ENABLE_GIT_RESET=false" \
    -e "ENABLE_GIT_CLEAN=false" \
    -e "BRANCH_NAME=lineage-16.0" \
    -e "DEVICE_LIST=dipper" \
    -e "SIGN_BUILDS=false" \
    -e "SIGNATURE_SPOOFING=no" \
    -e "WITH_GMS=false" \
    -e "CLEAN_AFTER_BUILD=false" \
    -e "USE_PYTHON2=true" \
    -e "USE_GCC9=true" \
    -v "$(pwd)/out/lineage-16.0/lineage:/srv/src" \
    -v "$(pwd)/out/lineage-16.0/zips:/srv/zips" \
    -v "$(pwd)/out/lineage-16.0/logs:/srv/logs" \
    -v "$(pwd)/out/lineage-16.0/cache:/srv/ccache" \
    -v "$(pwd)/out/lineage-16.0/keys:/srv/keys" \
    -v "$(pwd)/out/lineage-16.0/manifests:/srv/local_manifests" \
    ghcr.io/hellodword/docker-lineage-cicd:dev2023
```

### lineageos-17.1 (10)
### lineageos-18.1 (11)
### lineageos-19.1 (12.1)
### lineageos-20.0 (13)

---

## Youpk

- https://github.com/Youlor/unpacker/tree/LineageOS-14.1
- https://github.com/Humenger/Youpk8

### randomize

- cjson
- UNPACKER_WORKSPACE
- non-root DumpDir: /data/local/tmp/ or CacheDir or specfic path
- class name
- log tag

### [android-8.0.0_r21](./youpk/android-8.0.0_r21)

```sh
# generate android-8.0.0_r21 from https://github.com/Humenger/Youpk8
# not verified
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

### [lineageos-15.1 (8.1.0)](./youpk/lineageos-15.1)

> verified

```sh
# 假设已经正常编译过一次，在 out/lineage-15.1

sudo rm -rf out/userscripts
cp -r userscripts out/
sudo chown -R root:root "$(pwd)/out/userscripts"
sudo chmod +x "$(pwd)/out/userscripts/lineageos-15.1/before.sh"

sudo rm -rf out/youpk
cp -r youpk out/
sudo chown -R root:root "$(pwd)/out/youpk"
sudo chmod +x "$(pwd)/out/youpk/lineageos-15.1/build.patch.sh"

docker run --rm \
    -e "REPO_SYNC=false" \
    -e "REPO_INIT=false" \
    -e "UPDATE_PROPRIETARY=false" \
    -e "ENABLE_GIT_RESET=false" \
    -e "ENABLE_GIT_CLEAN=false" \
    -e "BRANCH_NAME=lineage-15.1" \
    -e "DEVICE_LIST=bullhead" \
    -e "SIGN_BUILDS=false" \
    -e "SIGNATURE_SPOOFING=no" \
    -e "WITH_GMS=false" \
    -e "USE_PYTHON2=true" \
    -e "USE_GCC9=true" \
    -v "$(pwd)/out/userscripts/lineageos-15.1:/root/userscripts:ro" \
    -v "$(pwd)/out/youpk/lineageos-15.1:/root/patch/main:ro" \
    -v "$(pwd)/out/youpk/common:/root/patch/common:ro" \
    -v "$(pwd)/out/lineage-15.1/lineage:/srv/src" \
    -v "$(pwd)/out/lineage-15.1/zips:/srv/zips" \
    -v "$(pwd)/out/lineage-15.1/logs:/srv/logs" \
    -v "$(pwd)/out/lineage-15.1/cache:/srv/ccache" \
    -v "$(pwd)/out/lineage-15.1/keys:/srv/keys" \
    -v "$(pwd)/out/lineage-15.1/manifests:/srv/local_manifests" \
    ghcr.io/hellodword/docker-lineage-cicd:dev2023
```


### lineageos-16.0 (9.0.0)
### lineageos-17.1 (10)
### lineageos-18.1 (11)
### lineageos-19.1 (12.1)
### lineageos-20.0 (13)


---

## reproducible

- https://www.reddit.com/r/LineageOS/comments/9bqlze/why_make_lineageos_builds_with_zero_changes/

---

- https://wiki.lineageos.org/devices/bullhead/
- https://github.com/lineageos4microg/docker-lineage-cicd
- https://github.com/julianxhokaxhiu/docker-lineage-cicd
- https://github.com/jfloff/docker-lineageos
