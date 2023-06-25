# https://github.com/lineageos4microg/docker-lineage-cicd/issues/298

FROM lineageos4microg/docker-lineage-cicd

RUN apt-get update

RUN env DEBIAN_FRONTEND=noninteractive apt-get install --yes python2
RUN update-alternatives --install /usr/bin/python python /usr/bin/python2 1

# https://github.com/BPI-SINOVOIP/BPI-M4-bsp/issues/4
RUN env DEBIAN_FRONTEND=noninteractive apt-get install --yes gcc-9
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 100 && \
    update-alternatives --config gcc

# for --depth 1
RUN sed -i 's/repo init/repo init $CUSTOM_REPO_INIT/g' /root/build.sh
# disable repo sync
RUN sed -i 's/repo sync/[ ! -z "$CUSTOM_REPO_SYNC_DISABLE" ] || repo sync/g' /root/build.sh
# add debug
RUN sed -i '/set -eEuo pipefail/a set -x' /root/build.sh