#!/bin/bash

export ANSIBLE_ROLES_PATH="../../../roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003

# AB: make sure tpl003 is running.
[ "$(sudo virsh domstate $TESTDOMAIN)" == "running" ] || { echo "ERROR: $TESTDOMAIN must be running for test"; exit 1; }

# AB: power off the VM and wait for it to be powered down.
sudo virsh destroy $TESTDOMAIN
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' test.yml

# Test to verify that the VM is powered off.
if [ "$(sudo virsh domstate $TESTDOMAIN)" != "shut off" ]; then
  echo "ERROR: $TESTDOMAIN is not shut off" >&2
  exit 1
fi
exit 0
