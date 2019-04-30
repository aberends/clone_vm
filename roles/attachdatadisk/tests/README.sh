#!/bin/bash

export ANSIBLE_ROLES_PATH="../../../roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003

# To run the test, use:
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'attachdatadisk_vg=fedora ansible_become_pass=redhat' test.yml
