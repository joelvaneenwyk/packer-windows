#!/bin/bash

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update
sudo apt-get install -y packer ansible

export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
sudo apt-get purge -y virtualbox
sudo apt-get remove -y virtualbox-dkms

# sudo apt-get install -y virtualbox virtualbox-ext-pack virtualbox-dkms dkms

python3 -m pip install --upgrade pip
python3 -m pip install --user ansible
