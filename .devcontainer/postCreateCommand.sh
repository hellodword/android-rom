#! /bin/bash

set -e
set -x

# curl -f -o ~/.git-completion.bash \
#     https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

# cat << EOF >> ~/.bashrc
# if [ -f ~/.git-completion.bash ]; then
#   . ~/.git-completion.bash
# fi
# EOF


# sudo chown $(id -u):$(id -g) $HOME
# sudo chown -R $(id -u):$(id -g) $HOME/.cache
# sudo chown -R $(id -u):$(id -g) $HOME/.vscode-server

if [[ "$DEVCONTAINER_LINEAGEOS_VERSION" = "15.1" || "$DEVCONTAINER_LINEAGEOS_VERSION" = "16.0" ]]; then
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 100
    sudo update-alternatives --config python

    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 100
    sudo update-alternatives --config gcc
fi