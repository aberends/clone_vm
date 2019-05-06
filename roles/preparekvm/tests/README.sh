#!/bin/bash

export ANSIBLE_ROLES_PATH="../../../roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN="tpl003"

ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' test.yml -vv

# AB: test with non-existing user specified VG
#ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat create_tpl_vm_vg=vma' test.yml

# AB: test with existing user specified VG
#sudo virsh pool-destroy vm
#sudo virsh pool-undefine vm
#ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat create_tpl_vm_vg=vm' test.yml
