#! /bin/bash

set -eEo pipefail
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

UNPACK_JAVA_CLASS_NAME="${UNPACK_JAVA_CLASS##*.}"
UNPACK_JAVA_CLASS_PACKAGE="${UNPACK_JAVA_CLASS%.*}"
UNPACK_JAVA_CLASS_PATH=$(echo $UNPACK_JAVA_CLASS | sed 's/\./\//g')
UNPACK_JAVA_CLASS_NATIVE=$(echo $UNPACK_JAVA_CLASS | sed 's/\./_/g')

rm -rf "art/runtime/$UNPACK_UNPACKER_LOWER"

mkdir -p "frameworks/base/core/java/$UNPACK_JAVA_CLASS_PATH"
mv frameworks/base/core/java/cn/youlor/Unpacker.java "frameworks/base/core/java/$UNPACK_JAVA_CLASS_PATH/$UNPACK_JAVA_CLASS_NAME.java"
mv art/runtime/unpacker "art/runtime/$UNPACK_UNPACKER_LOWER"
mv "art/runtime/$UNPACK_UNPACKER_LOWER/unpacker.cc" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.cc"
mv "art/runtime/$UNPACK_UNPACKER_LOWER/unpacker.h" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.h"
mv "art/runtime/$UNPACK_UNPACKER_LOWER/cJSON.h" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_CJSON.h"

sed -i "s/unpacker\.config/$UNPACK_CONFIG_FILE/g" "frameworks/base/core/java/$UNPACK_JAVA_CLASS_PATH/$UNPACK_JAVA_CLASS_NAME.java"
sed -i "s/unpacker\.config/$UNPACK_CONFIG_FILE/g" art/dex2oat/dex2oat.cc
sed -i "s/unpacker\.config/$UNPACK_CONFIG_FILE/g" frameworks/native/cmds/installd/dexopt.cpp

sed -i "s/ULOG_TAG \"unpacker\"/ULOG_TAG \"$UNPACK_LOG_TAG\"/g" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.cc"
sed -i "s/UNPACKER_WORKSPACE \"unpacker\"/UNPACKER_WORKSPACE \"$UNPACK_LOG_TAG\"/g" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.cc"

sed -i "s/Unpacker/$UNPACK_JAVA_CLASS_NAME/g" "frameworks/base/core/java/$UNPACK_JAVA_CLASS_PATH/$UNPACK_JAVA_CLASS_NAME.java"
sed -i "s/cn\.youlor/$UNPACK_JAVA_CLASS_PACKAGE/g" "frameworks/base/core/java/$UNPACK_JAVA_CLASS_PATH/$UNPACK_JAVA_CLASS_NAME.java"

sed -i "s/cn_youlor_Unpacker/$UNPACK_JAVA_CLASS_NATIVE/g" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.cc"
sed -i "s/cn\/youlor\/Unpacker/$UNPACK_JAVA_CLASS/g" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.cc"
sed -i "s/cn_youlor_Unpacker/$UNPACK_JAVA_CLASS_NATIVE/g" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.h"

sed -i "s/cn_youlor_Unpacker/$UNPACK_JAVA_CLASS_NATIVE/g" art/runtime/runtime.cc

sed -i "s/cn\.youlor\.Unpacker/$UNPACK_JAVA_CLASS/g" frameworks/base/core/java/android/app/ActivityThread.java
sed -i "s/Unpacker/$UNPACK_JAVA_CLASS_NAME/g" frameworks/base/core/java/android/app/ActivityThread.java

sed -i "s/cn\\\.youlor/$(echo $UNPACK_JAVA_CLASS_PACKAGE | sed 's/\./\\\\./g')/g" ./build/make/core/tasks/check_boot_jars/package_whitelist.txt


sed -i "s/unpacker/$UNPACK_UNPACKER_LOWER/g" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.cc"
sed -i "s/unpacker/$UNPACK_UNPACKER_LOWER/g" "frameworks/base/core/java/$UNPACK_JAVA_CLASS_PATH/$UNPACK_JAVA_CLASS_NAME.java"

sed -i "s/unpacker/$UNPACK_UNPACKER_LOWER/g" art/dex2oat/dex2oat.cc
sed -i "s/unpacker/$UNPACK_UNPACKER_LOWER/g" art/runtime/Android.bp
sed -i "s/unpacker/$UNPACK_UNPACKER_LOWER/g" art/runtime/art_method.cc
sed -i "s/unpacker/$UNPACK_UNPACKER_LOWER/g" art/runtime/interpreter/interpreter_switch_impl.cc
sed -i "s/unpacker/$UNPACK_UNPACKER_LOWER/g" art/runtime/runtime.cc

sed -i "s/unpacker/$UNPACK_UNPACKER_LOWER/g" frameworks/native/cmds/installd/dexopt.cpp

sed -i "s/Unpacker/$UNPACK_UNPACKER_UPPER/g" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.cc"
sed -i "s/Unpacker/$UNPACK_UNPACKER_UPPER/g" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.h"
sed -i "s/Unpacker/$UNPACK_UNPACKER_UPPER/g" art/runtime/art_method.cc
sed -i "s/Unpacker/$UNPACK_UNPACKER_UPPER/g" art/runtime/class_linker.h
sed -i "s/Unpacker/$UNPACK_UNPACKER_UPPER/g" art/runtime/interpreter/interpreter_switch_impl.cc
sed -i "s/Unpacker/$UNPACK_UNPACKER_UPPER/g" art/runtime/runtime.cc

sed -i "s/unpackNative/$UNPACK_UNPACK_NATIVE/g" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.cc"
sed -i "s/unpackNative/$UNPACK_UNPACK_NATIVE/g" "frameworks/base/core/java/$UNPACK_JAVA_CLASS_PATH/$UNPACK_JAVA_CLASS_NAME.java"

sed -i "s/unpack(/$UNPACK_UNPACK(/g" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.cc"
sed -i "s/unpack(/$UNPACK_UNPACK(/g" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.h"
sed -i "s/unpack(/$UNPACK_UNPACK(/g" "frameworks/base/core/java/$UNPACK_JAVA_CLASS_PATH/$UNPACK_JAVA_CLASS_NAME.java"
sed -i "s/unpack(/$UNPACK_UNPACK(/g" frameworks/base/core/java/android/app/ActivityThread.java

sed -i "s/cjson/$UNPACK_CJSON/gi" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.cc"
sed -i "s/cjson/$UNPACK_CJSON/gi" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.h"
sed -i "s/cjson/$UNPACK_CJSON/gi" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_CJSON.h"

sed -i "s/isFakeInvoke/$UNPACK_isFakeInvoke/g" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.cc"
sed -i "s/isFakeInvoke/$UNPACK_isFakeInvoke/g" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.h"
sed -i "s/isFakeInvoke/$UNPACK_isFakeInvoke/g" art/runtime/art_method.cc

sed -i "s/afterInstructionExecute/$UNPACK_afterInstructionExecute/g" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.cc"
sed -i "s/afterInstructionExecute/$UNPACK_afterInstructionExecute/g" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.h"
sed -i "s/afterInstructionExecute/$UNPACK_afterInstructionExecute/g" art/runtime/interpreter/interpreter_switch_impl.cc

sed -i "s/beforeInstructionExecute/$UNPACK_beforeInstructionExecute/g" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.cc"
sed -i "s/beforeInstructionExecute/$UNPACK_beforeInstructionExecute/g" "art/runtime/$UNPACK_UNPACKER_LOWER/$UNPACK_UNPACKER_LOWER.h"
sed -i "s/beforeInstructionExecute/$UNPACK_beforeInstructionExecute/g" art/runtime/interpreter/interpreter_switch_impl.cc
