#!/bin/bash

export ANSIBLE_ROLES_PATH="../../../roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003

# To run the test, use:
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' test.yml

# Test to verify that the VM has the extra pcie-root-port
sudo grep -q "index='8'" /etc/libvirt/qemu/${TESTDOMAIN}.xml
if [[ $? -ne 0 ]]; then
  echo "ERROR: $TESTDOMAIN has no extra pcie-root-port" >&2
  exit 1
fi
exit 0
