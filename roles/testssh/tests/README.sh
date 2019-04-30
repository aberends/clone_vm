#!/bin/bash

export ANSIBLE_ROLES_PATH="../../../roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003

# To run the test, use:
ansible-playbook --inventory=$TESTDOMAIN, test.yml

# Test to verify that the VM has SSH connection.
if ! nmap -sn -PS22 $TESTDOMAIN -oG - | grep -q 'Status: Up'; then
  echo "ERROR: $TESTDOMAIN has no SSH connection" >&2
  exit 1
fi
exit 0
