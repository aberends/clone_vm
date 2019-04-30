#!/bin/bash

export ANSIBLE_ROLES_PATH="../../../roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003

# AB: the following test fails because no VG is given.
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' test.yml

# AB: the volume is created because the variable
# makevolume_vg is set to a valid VG.
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat makevolume_vg=fedora' test.yml

# AB: match on the word boundaries ("\<" and "\>") since
# the data disk and template disk, d$TESTDOMAIN and
# t$TESTDOMAIN, can exist.
sudo lvs -o lv_name --noheadings | grep -q "\<$TESTDOMAIN\>"
if [[ $? -ne 0 ]]; then
  echo "ERROR: disk $TESTDOMAIN does not exist" >&2
  exit 1
fi
exit 0
