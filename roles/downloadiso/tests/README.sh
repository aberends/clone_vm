#!/bin/bash

export ANSIBLE_ROLES_PATH="../../../roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003

ansible-playbook --inventory=$TESTDOMAIN, test.yml

#mkdir ~/test
#ansible-playbook --inventory=$TESTDOMAIN, test.yml --extra-vars 'downloadiso_clone_vm_dir=~/test'

#mkdir ~/test
#ansible-playbook --inventory=$TESTDOMAIN, test.yml --extra-vars 'downloadiso_clone_vm_dir=~/test downloadiso_distribution_url="https://getfedora.org/en/server/download/" downloadiso_iso_pattern="Fedora-Server-dvd-x86_64-29-*.iso" downloadiso_url_pattern="https://.*Fedora-Server-dvd-x86_64-29-.*\.iso"'
