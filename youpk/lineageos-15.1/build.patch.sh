#! /bin/bash

# build in lineageos is not a .git

grep Youlor ./build/make/core/tasks/check_boot_jars/package_whitelist.txt || \
cat << EOT >> ./build/make/core/tasks/check_boot_jars/package_whitelist.txt
#patch by Youlor
#++++++++++++++++++++++++++++
cn\.youlor
#++++++++++++++++++++++++++++
EOT
