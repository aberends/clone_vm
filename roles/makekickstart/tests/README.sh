#!/bin/bash

export ANSIBLE_ROLES_PATH="../../../roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
SYSTEM_TZ=$(timedatectl show -p Timezone --value)

ansible-playbook --inventory=$TESTDOMAIN, --limit=$TESTDOMAIN test.yml
if ! grep -q "$SYSTEM_TZ" ~/clone_vm/$TESTDOMAIN.ks; then
  echo "ERROR: kickstart file does not have $SYSTEM_TZ" >&2
  exit 1
fi

ansible-playbook --inventory=$TESTDOMAIN, --limit=$TESTDOMAIN --extra-vars 'makekickstart_timezone=America/Antigua makekickstart_root_pw=password' test.yml
#ansible-playbook --inventory=$TESTDOMAIN, --limit=$TESTDOMAIN --extra-vars 'makekickstart_timezone=America/Antigua' test.yml
if ! grep -q "America/Antigua" ~/clone_vm/$TESTDOMAIN.ks; then
  echo "ERROR: kickstart file does not have America/Antigua" >&2
  exit 1
fi
exit 0
