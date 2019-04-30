#!/bin/bash

export ANSIBLE_ROLES_PATH="../../../roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003

ansible-playbook --user=root --inventory=$TESTDOMAIN, --extra-vars 'createtemplatedisk_vg=fedora' test.yml
