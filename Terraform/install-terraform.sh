#!/bin/bash

# Original doc: https://learn.hashicorp.com/tutorials/terraform/install-cli 
# Prerequisites
# Ubuntu, wget

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform
terraform -v


# Or you can go for brew installation (Mac and Linux both support it, for Windows is a bit complicated but you can always use the magic power of WSL Ubuntu)

brew tap hashicorp/tap
brew install hashicorp/tap/terraform
brew update
brew upgrade hashicorp/tap/terraform
terraform -v

# In any case you should run these command for tab autocompletion

touch ~/.bashrc
terraform -install-autocomplete