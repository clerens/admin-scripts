#!/bin/bash



function main {
    if ! [ -x "$(command -v docker)" ]; then
        echo "Docker is not present. Do you want to perform an installation? (yes/no)"
        read perform_install
        if [ $perform_install == "yes" ]; then
            install_docker
            exit 0
        else
            echo "Installation cancelled."
            exit 1
        fi
    else
        echo "Docker already installed"
        exit 0
    fi
    }

function install_docker {
    # Setup the repository

    apt-get update

    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    apt-key fingerprint 0EBFCD88

    add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"

    apt-get update

    apt-get install -y docker-ce docker-ce-cli containerd.io
}

main