# android-rom

## IDE

- https://www.protechtraining.com/blog/post/aosp-sources-in-the-ide-860
- https://github.com/amezin/aosp-vscode
- https://connolly.tech/posts/2022_07_20-aosp-vscode/#aosp-and-vscode
- https://groups.google.com/g/android-building/c/pC2DrNLz9C8
- https://github.com/LineageOS/android_build_soong/blob/396c6159ef7912e1c72235d631291039a40e664f/docs/compdb.md
- https://github.com/LineageOS/android_build_soong/blob/396c6159ef7912e1c72235d631291039a40e664f/docs/clion.md
- https://wiki.lineageos.org/how-to/import-to-android-studio
- https://shuhaowu.com/archive/2021/blog/setting_up_intellij_with_aosp_development.html
- https://blog.udinic.com/2014/07/24/aosp-part-3-developing-efficiently/
- https://github.com/Ahren-Li/android-cmake-project
- https://ckcat.github.io/2019/11/13/%E4%BD%BF%E7%94%A8Clion%E8%B0%83%E8%AF%95Android-native%E6%BA%90%E7%A0%81/
- https://github.com/nickdiego/compiledb/blob/b615d526019c7b809882090ea7eaff85423f2b13/examples/compiledb-aosp.sh
- https://android.googlesource.com/platform/tools/asuite/+/refs/heads/master/aidegen/README.md

### Android Studio

```sh
# 必须完整编译一次后

mmm development/tools/idegen/
development/tools/idegen/idegen.sh

# 必须是导入 `android.ipr` 文件而不是 AOSP 目录
```

### VSCode

```sh
# env SOONG_GEN_COMPDB=1 SOONG_GEN_COMPDB_DEBUG=1 mka nothing

# 完整编译一次后，进 devcontainer
# 注意要在 docker exec 的 bash 中执行，VSCode Terminal 中会有奇怪的错误
# docker exec -it -w /android-rom/src/LINEAGE_16_0/ <container name> /bin/bash
source build/envsetup.sh 
lunch lineage_x86_64-eng
mka sdk_addon
```

## build lineageos with docker

> for bullhead lineage-15.1, `--depth=1` reduces ~50GB (~130GB => ~80GB)

### lineage-15.1 (8.1.0)

```sh
mkdir -p out/lineage-15.1

# 同步和编译，禁用 microg 的 patch
docker run --rm \
    -e "VERBOSE=true" \
    -e "REPO_INIT_ARGS=--depth=1" \
    -e "BRANCH_NAME=lineage-15.1" \
    -e "DEVICE_LIST=bullhead" \
    -e "SIGN_BUILDS=false" \
    -e "SIGNATURE_SPOOFING=no" \
    -e "WITH_GMS=false" \
    -e "CLEAN_AFTER_BUILD=false" \
    -e "USE_PYTHON2=true" \
    -e "USE_GCC9=true" \
    -v "$(pwd)/src:/android-rom/src" \
    -v "$(pwd)/out/lineage-15.1/zips:/android-rom/zips" \
    -v "$(pwd)/out/lineage-15.1/logs:/android-rom/logs" \
    -v "$(pwd)/out/lineage-15.1/cache:/android-rom/ccache" \
    -v "$(pwd)/out/lineage-15.1/keys:/android-rom/keys" \
    -v "$(pwd)/out/lineage-15.1/manifests:/android-rom/local_manifests" \
    ghcr.io/hellodword/docker-lineage-cicd:dev2023

# 修改代码后，不同步，只编译
docker run --rm \
    -e "VERBOSE=true" \
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
    -v "$(pwd)/src:/android-rom/src" \
    -v "$(pwd)/out/lineage-15.1/zips:/android-rom/zips" \
    -v "$(pwd)/out/lineage-15.1/logs:/android-rom/logs" \
    -v "$(pwd)/out/lineage-15.1/cache:/android-rom/ccache" \
    -v "$(pwd)/out/lineage-15.1/keys:/android-rom/keys" \
    -v "$(pwd)/out/lineage-15.1/manifests:/android-rom/local_manifests" \
    ghcr.io/hellodword/docker-lineage-cicd:dev2023
```

### lineage-16.0 (9.0.0)

```sh
mkdir -p out/lineage-16.0

# 同步和编译，禁用 microg 的 patch
docker run --rm \
    -e "VERBOSE=true" \
    -e "REPO_INIT_ARGS=--depth=1" \
    -e "BRANCH_NAME=lineage-16.0" \
    -e "DEVICE_LIST=dipper" \
    -e "SIGN_BUILDS=false" \
    -e "SIGNATURE_SPOOFING=no" \
    -e "WITH_GMS=false" \
    -e "CLEAN_AFTER_BUILD=false" \
    -e "USE_PYTHON2=true" \
    -e "USE_GCC9=true" \
    -v "$(pwd)/src:/android-rom/src" \
    -v "$(pwd)/out/lineage-16.0/zips:/android-rom/zips" \
    -v "$(pwd)/out/lineage-16.0/logs:/android-rom/logs" \
    -v "$(pwd)/out/lineage-16.0/cache:/android-rom/ccache" \
    -v "$(pwd)/out/lineage-16.0/keys:/android-rom/keys" \
    -v "$(pwd)/out/lineage-16.0/manifests:/android-rom/local_manifests" \
    ghcr.io/hellodword/docker-lineage-cicd:dev2023

# 修改代码后，不同步，只编译
docker run --rm \
    -e "VERBOSE=true" \
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
    -v "$(pwd)/src:/android-rom/src" \
    -v "$(pwd)/out/lineage-16.0/zips:/android-rom/zips" \
    -v "$(pwd)/out/lineage-16.0/logs:/android-rom/logs" \
    -v "$(pwd)/out/lineage-16.0/cache:/android-rom/ccache" \
    -v "$(pwd)/out/lineage-16.0/keys:/android-rom/keys" \
    -v "$(pwd)/out/lineage-16.0/manifests:/android-rom/local_manifests" \
    ghcr.io/hellodword/docker-lineage-cicd:dev2023
```

### lineageos-17.1 (10)


```sh
mkdir -p out/lineage-17.1

# 同步和编译，禁用 microg 的 patch
docker run --rm \
    -e "VERBOSE=true" \
    -e "REPO_INIT_ARGS=--depth=1" \
    -e "BRANCH_NAME=lineage-17.1" \
    -e "DEVICE_LIST=dipper" \
    -e "SIGN_BUILDS=false" \
    -e "SIGNATURE_SPOOFING=no" \
    -e "WITH_GMS=false" \
    -e "CLEAN_AFTER_BUILD=false" \
    -v "$(pwd)/src:/android-rom/src" \
    -v "$(pwd)/out/lineage-17.1/zips:/android-rom/zips" \
    -v "$(pwd)/out/lineage-17.1/logs:/android-rom/logs" \
    -v "$(pwd)/out/lineage-17.1/cache:/android-rom/ccache" \
    -v "$(pwd)/out/lineage-17.1/keys:/android-rom/keys" \
    -v "$(pwd)/out/lineage-17.1/manifests:/android-rom/local_manifests" \
    ghcr.io/hellodword/docker-lineage-cicd:dev2023

# 修改代码后，不同步，只编译
docker run --rm \
    -e "VERBOSE=true" \
    -e "REPO_SYNC=false" \
    -e "REPO_INIT=false" \
    -e "UPDATE_PROPRIETARY=false" \
    -e "ENABLE_GIT_RESET=false" \
    -e "ENABLE_GIT_CLEAN=false" \
    -e "BRANCH_NAME=lineage-17.1" \
    -e "DEVICE_LIST=dipper" \
    -e "SIGN_BUILDS=false" \
    -e "SIGNATURE_SPOOFING=no" \
    -e "WITH_GMS=false" \
    -e "CLEAN_AFTER_BUILD=false" \
    -v "$(pwd)/src:/android-rom/src" \
    -v "$(pwd)/out/lineage-17.1/zips:/android-rom/zips" \
    -v "$(pwd)/out/lineage-17.1/logs:/android-rom/logs" \
    -v "$(pwd)/out/lineage-17.1/cache:/android-rom/ccache" \
    -v "$(pwd)/out/lineage-17.1/keys:/android-rom/keys" \
    -v "$(pwd)/out/lineage-17.1/manifests:/android-rom/local_manifests" \
    ghcr.io/hellodword/docker-lineage-cicd:dev2023
```


### lineageos-18.1 (11)
### lineageos-19.1 (12.1)
### lineageos-20.0 (13)

### avd


```sh
docker run --rm \
    -e "VERBOSE=true" \
    -e "VERBOSE=true" \
    -e "REPO_SYNC=false" \
    -e "REPO_INIT=false" \
    -e "UPDATE_PROPRIETARY=false" \
    -e "ENABLE_GIT_RESET=false" \
    -e "ENABLE_GIT_CLEAN=false" \
    -e "BRANCH_NAME=lineage-16.0" \
    -e "DEVICE_LIST=generic_x86_64" \
    -e "AVD_TARGET=x86_64" \
    -e "SIGN_BUILDS=false" \
    -e "SIGNATURE_SPOOFING=no" \
    -e "WITH_GMS=false" \
    -e "CLEAN_AFTER_BUILD=false" \
    -e "USE_PYTHON2=true" \
    -e "USE_GCC9=true" \
    -v "$(pwd)/src:/android-rom/src" \
    -v "$(pwd)/out/lineage-16.0/zips:/android-rom/zips" \
    -v "$(pwd)/out/lineage-16.0/logs:/android-rom/logs" \
    -v "$(pwd)/out/lineage-16.0/cache:/android-rom/ccache" \
    -v "$(pwd)/out/lineage-16.0/keys:/android-rom/keys" \
    -v "$(pwd)/out/lineage-16.0/manifests:/android-rom/local_manifests" \
    ghcr.io/hellodword/docker-lineage-cicd:dev2023
```

```sh
# 先去 sdk manager 把对应的 api level 的镜像取消勾选，例如 android-28
mkdir -p ~/Android/Sdk/system-images/android-28/google_apis/x86_64
# 把 out/lineage-16.0/zips/generic_x86_64/sdk_addon/lineage-eng.root-linux-x86-img.zip 解压进去
# 就可以在 AVD 里看到对应的镜像

# # arm on x86_64
# emulator -avd Pixel_6_Pro_API_27 -verbose -engine qemu2 -read-only -qemu -machine virt

# # x86_64 on x86_64
# emulator -avd Pixel_6_Pro_API_28 -verbose
```

```sh
# https://github.com/google/android-emulator-container-scripts
emu-docker list

wget https://dl.google.com/android/repository/emulator-linux_x64-10086546.zip

emu-docker -v create emulator-linux_x64-10086546.zip lineage-eng.root-linux-x86-img.zip --no-metrics

# TODO
#   adb
#   adb root
docker run \
  --rm \
  -e ADBKEY="$(cat ~/.android/adbkey)" \
  --device /dev/kvm \
  --publish 8554:8554/tcp \
  --publish 5555:5555/tcp  \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=$DISPLAY \
  us-docker.pkg.dev/android-emulator-268719/images/28-lineage-x64-no-metrics
```

---

## Youpk

- https://github.com/Youlor/unpacker/tree/LineageOS-14.1
- https://github.com/Humenger/Youpk8
- https://github.com/dqzg12300/FartExt
- https://github.com/CrackerCat/simpread/blob/main/md/%5B%E5%8E%9F%E5%88%9B%5DFartExt%20%E4%B9%8B%E4%BC%98%E5%8C%96%E6%9B%B4%E6%B7%B1%E4%B8%BB%E5%8A%A8%E8%B0%83%E7%94%A8%E7%9A%84%20FART10.md
- https://github.com/shizenghua/Learn-and-Think-More/blob/master/Android%20Security/Android%E9%80%86%E5%90%91/%E8%84%B1%E5%A3%B3%E5%88%86%E6%9E%90/%E8%84%B1%E5%A3%B3%E6%9C%BA/%E7%90%86%E8%AE%BA/%E5%B0%86FART%E5%92%8CYoupk%E7%BB%93%E5%90%88%E6%9D%A5%E5%81%9A%E4%B8%80%E6%AC%A1%E9%92%88%E5%AF%B9%E5%87%BD%E6%95%B0%E6%8A%BD%E5%8F%96%E5%A3%B3%E7%9A%84%E5%85%A8%E9%9D%A2%E6%8F%90%E5%8D%87.md
- https://chinggg.github.io/post/fart/#youpk-%E6%BA%90%E7%A0%81%E8%A7%A3%E8%AF%BB

### randomize

- [x] remove cjson
- [x] non-root DumpDir: /data/local/tmp/ or CacheDir or specfic path
- [ ] skip
- [ ] hide symbols
- [ ] log tag

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

chmod +x "$(pwd)/userscripts/lineageos-15.1/before.sh" && \
chmod +x "$(pwd)/youpk/lineageos-15.1/build.patch.sh" && \
docker run --rm \
    -e "UNPACK_RAND=false" \
    -e "UNPACK_CONFIG_FILE=miui.config" \
    -e "UNPACK_LOG_TAG=woowoo" \
    -e "UNPACK_OUTPUT_DIR=oowoow" \
    -e "UNPACK_JAVA_CLASS=com.android.miui.pushd.Pusher" \
    -e "UNPACK_UNPACKER_LOWER=milink" \
    -e "UNPACK_UNPACKER_UPPER=Milink" \
    -e "UNPACK_UNPACK_NATIVE=jump" \
    -e "UNPACK_UNPACK=printk" \
    -e "UNPACK_CJSON=mipush" \
    -e "UNPACK_isFakeInvoke=a" \
    -e "UNPACK_afterInstructionExecute=b" \
    -e "UNPACK_beforeInstructionExecute=c" \
    -e "VERBOSE=true" \
    -e "REPO_SYNC=false" \
    -e "REPO_INIT=false" \
    -e "UPDATE_PROPRIETARY=false" \
    -e "ENABLE_GIT_RESET=false" \
    -e "ENABLE_GIT_CLEAN=false" \
    -e "BRANCH_NAME=lineage-15.1" \
    -e "DEVICE_LIST=bullhead" \
    -e "SIGN_BUILDS=false" \
    -e "BUILD_TYPE=eng" \
    -e "SIGNATURE_SPOOFING=no" \
    -e "WITH_GMS=false" \
    -e "USE_PYTHON2=true" \
    -e "USE_GCC9=true" \
    -e "USERSCRIPTS_FAIL=true" \
    -v "$(pwd)/userscripts/lineageos-15.1:/home/ubuntu/userscripts:ro" \
    -v "$(pwd)/youpk/lineageos-15.1:/home/ubuntu/patch:ro" \
    -v "$(pwd)/src:/android-rom/src" \
    -v "$(pwd)/out/lineage-15.1/zips:/android-rom/zips" \
    -v "$(pwd)/out/lineage-15.1/logs:/android-rom/logs" \
    -v "$(pwd)/out/lineage-15.1/cache:/android-rom/ccache" \
    -v "$(pwd)/out/lineage-15.1/keys:/android-rom/keys" \
    -v "$(pwd)/out/lineage-15.1/manifests:/android-rom/local_manifests" \
    ghcr.io/hellodword/docker-lineage-cicd:dev2023-non-root
```


### [lineageos-16.0 (9)](./youpk/lineageos-16.0)


```sh
# 假设已经正常编译过一次，在 out/lineage-16.0

chmod +x "$(pwd)/userscripts/lineageos-16.0/before.sh" && \
chmod +x "$(pwd)/youpk/lineageos-16.0/build.patch.sh" && \
docker run --rm \
    -e "UNPACK_RAND=false" \
    -e "UNPACK_CONFIG_FILE=miui.config" \
    -e "UNPACK_LOG_TAG=woowoo" \
    -e "UNPACK_OUTPUT_DIR=oowoow" \
    -e "UNPACK_JAVA_CLASS=com.android.miui.pushd.Pusher" \
    -e "UNPACK_UNPACKER_LOWER=milink" \
    -e "UNPACK_UNPACKER_UPPER=Milink" \
    -e "UNPACK_UNPACK_NATIVE=jump" \
    -e "UNPACK_UNPACK=printk" \
    -e "UNPACK_CJSON=mipush" \
    -e "UNPACK_isFakeInvoke=a" \
    -e "UNPACK_afterInstructionExecute=b" \
    -e "UNPACK_beforeInstructionExecute=c" \
    -e "VERBOSE=true" \
    -e "REPO_SYNC=false" \
    -e "REPO_INIT=false" \
    -e "UPDATE_PROPRIETARY=false" \
    -e "ENABLE_GIT_RESET=false" \
    -e "ENABLE_GIT_CLEAN=false" \
    -e "BRANCH_NAME=lineage-16.0" \
    -e "DEVICE_LIST=generic_x86_64" \
    -e "AVD_TARGET=x86_64" \
    -e "BUILD_TYPE=eng" \
    -e "SIGN_BUILDS=false" \
    -e "SIGNATURE_SPOOFING=no" \
    -e "WITH_GMS=false" \
    -e "USE_PYTHON2=true" \
    -e "USE_GCC9=true" \
    -e "USERSCRIPTS_FAIL=true" \
    -v "$(pwd)/userscripts/lineageos-16.0:/home/ubuntu/userscripts:ro" \
    -v "$(pwd)/youpk/lineageos-16.0:/home/ubuntu/patch:ro" \
    -v "$(pwd)/src:/android-rom/src" \
    -v "$(pwd)/out/lineage-16.0/zips:/android-rom/zips" \
    -v "$(pwd)/out/lineage-16.0/logs:/android-rom/logs" \
    -v "$(pwd)/out/lineage-16.0/cache:/android-rom/ccache" \
    -v "$(pwd)/out/lineage-16.0/keys:/android-rom/keys" \
    -v "$(pwd)/out/lineage-16.0/manifests:/android-rom/local_manifests" \
    ghcr.io/hellodword/docker-lineage-cicd:dev2023-non-root
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

- https://wiki.lineageos.org/emulator
- https://github.com/lineageos4microg/docker-lineage-cicd
- https://web.archive.org/web/20220813213500/http://www.trcompu.com/MySmartPhone/AndroidKitchen/Breakfast-Brunch-Lunch.html
- https://sourcegraph.com/github.com/LineageOS/android_art@lineage-15.1
- https://evilpan.com/2021/12/26/art-internal/
- https://github.com/BeesX/BeesAndroid

