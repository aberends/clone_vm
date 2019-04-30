#!/bin/bash

export ANSIBLE_ROLES_PATH="../../../roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003

ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' test.yml

# Test to verify that the VM has no CDROM.
if sudo grep -q cdrom /etc/libvirt/qemu/${TESTDOMAIN}.xml; then
  echo "ERROR: $TESTDOMAIN still has CDROM" >&2
  exit 1
fi

# AB: the second time no changes are shown in the play.
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' test.yml

# Test to verify that the VM has no CDROM.
if sudo grep -q cdrom /etc/libvirt/qemu/${TESTDOMAIN}.xml; then
  echo "ERROR: $TESTDOMAIN still has CDROM" >&2
  exit 1
fi
exit 0
