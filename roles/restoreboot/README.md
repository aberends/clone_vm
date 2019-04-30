# Introduction to restoreboot

The *restoreboot* creates a mountpoint and restores the boot
filesystem on it.

Since we are not interested in facts, we set **gather_facts:
false**.

## Example playbook

The path in which the *restoreboot* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`. The VM used has as domain name
**tpl003** (virsh list --all).

```
cat << _EOF_ > restore_boot.yml
---

- name: Test restoreboot role
  hosts: all
  gather_facts: false
  roles:
  - role: restoreboot
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' restore_boot.yml
```

Run the command again to verify that nothing changes since
the data disk is already prepared in the first run.

```
export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' restore_boot.yml
```

## License
GPL License.
