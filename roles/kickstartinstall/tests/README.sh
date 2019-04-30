#!/bin/bash

export ANSIBLE_ROLES_PATH="../../../roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003

ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' test.yml

ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat kickstartinstall_vg=fedora' test.yml
