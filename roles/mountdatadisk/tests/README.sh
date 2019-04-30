#!/bin/bash

export ANSIBLE_ROLES_PATH="../../../roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003

# To run the test, use:
ansible-playbook --user=root --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' test.yml
