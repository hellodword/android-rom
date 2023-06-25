#! /bin/bash

# build in lineageos is not a .git

[ -f ./build/make/core/tasks/check_boot_jars/package_whitelist.txt.backup ] || \
cp ./build/make/core/tasks/check_boot_jars/package_whitelist.txt ./build/make/core/tasks/check_boot_jars/package_whitelist.txt.backup

cp ./build/make/core/tasks/check_boot_jars/package_whitelist.txt.backup ./build/make/core/tasks/check_boot_jars/package_whitelist.txt

grep Youlor ./build/make/core/tasks/check_boot_jars/package_whitelist.txt || \
cat << EOT >> ./build/make/core/tasks/check_boot_jars/package_whitelist.txt
#patch by Youlor
#++++++++++++++++++++++++++++
cn\.youlor
#++++++++++++++++++++++++++++
EOT
