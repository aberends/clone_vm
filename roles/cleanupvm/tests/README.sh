#!/bin/bash

export ANSIBLE_ROLES_PATH="../../../roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003

# To run the test, use:
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat cleanupvm_vg="fedora"' test.yml

# Test to verify that the VM is powered off.
if sudo virsh list --name | grep -q $TESTDOMAIN; then
  echo "ERROR: $TESTDOMAIN is not undefined" >&2
  exit 1
fi
if sudo lvs -o lv_name --noheadings | grep -q $TESTDOMAIN; then
  echo "ERROR: disks [dt]?$TESTDOMAIN still exist" >&2
  exit 1
fi
exit 0
