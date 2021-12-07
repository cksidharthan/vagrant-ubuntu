#!/bin/bash

printf "\n----> Running devenv customization script <----\n"

sudo apt-get update

sudo apt-get install -y -q --fix-missing \
zsh \
shellcheck \
neovim \
gnupg2 \
make \
software-properties-common \
apt-transport-https \
dirmngr \
net-tools \
psmisc procps \
jq \
git \
curl

if [! -d /usr/local/go ]; then
    printf "\n---> Installing Go 1.16.7...\n"
    wget -q https://golang.org/dl/go1.16.7.linux-amd64.tar.gz
    tar -xf go1.16.7.linux-amd64.tar.gz
    mv go /usr/local
else
    printf "\n---> Go installed"
fi

# Remove green highlighting of folders in windows
echo 'LS_COLORS="$LS_COLORS:tw=01;34:ow=01;34:st=01;34"' >> ~/.bashrc 

# Install zsh 
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"