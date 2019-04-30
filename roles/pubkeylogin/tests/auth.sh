#!/bin/bash

export ANSIBLE_HOST_KEY_CHECKING="false"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003

# AB: note we use the user root as the ansible user here.
# The ansible process itself is run under the user which is
# used to start the process.
ansible-playbook --user root --inventory=$TESTDOMAIN, --extra-vars 'ansible_ssh_pass=redhat' auth.yml
