#!/bin/bash

# Expectes Python3.9
export PYTHON3_BIN=$(which python3.9)
export PIP3_BIN=$(which pip3.9)
export UNAME=$(uname)

# Pipepeline situation
if [ -z "$WORKSPACE" ]; then
  export JANNAH_WORKING_DIR=$(pwd)
else
  export JANNAH_WORKING_DIR=$WORKSPACE
fi


if [ -z "$PYTHONPATH" ]
then
    PYTHONPATH=$JANNAH_WORKING_DIR
else
    PYTHONPATH=$JANNAH_WORKING_DIR:$PYTHONPATH
fi

export PYTHONPATH
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_CONFIG=$(pwd)/ansible/ansible.cfg
export JANNAH_ENV="jannah-boot"
export ANSIBLE_VAULT_DEFAULT_PASS_FILE="$HOME/defaultpass.txt"

$PIP3_BIN install --upgrade pip
$PIP3_BIN install ansible
#ls -lrt $ANSIBLE_CONFIG


$PYTHON3_BIN --version
$PIP3_BIN --version

echo "Installing Ansible"
$PYTHON3_BIN -m pip install --upgrade pip
$PIP3_BIN install virtualenv
virtualenv --always-copy --python $PYTHON3_BIN $JANNAH_ENV
source $JANNAH_ENV/bin/activate
$PYTHON3_BIN  -m pip install ansible molecule ansible-lint
ansible-galaxy collection install --force kubernetes.core
$PYTHON3_BIN  -m pip install kubernetes

echo "ANSIBLE_VAULT_DEFAULT_PASS_FILE: $ANSIBLE_VAULT_DEFAULT_PASS_FILE"