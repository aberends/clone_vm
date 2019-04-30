#!/bin/bash

export ANSIBLE_HOST_KEY_CHECKING="false"
export ANSIBLE_RETRY_FILES_ENABLED="false"
export ANSIBLE_ROLES_PATH="../../../roles"
TESTDOMAIN=tpl003

ansible-playbook --user root --inventory=$TESTDOMAIN, --extra-vars 'ansible_ssh_pass=redhat' test.yml

# Test to verify that the user can login.
if [ "$(ssh -o BatchMode=yes -l root $TESTDOMAIN 'echo pubkeylogin')" != "pubkeylogin" ]; then
  echo "ERROR: $TESTDOMAIN does not allow pubkey authentication for $USER" >&2
  exit 1
fi
exit 0
