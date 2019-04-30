# Introduction to restoreroot

The *restoreroot* role creates mount points on the VM and
mounts the template disk on it. Next it restores the root
filesystem.

Since we don't need facts about the VM we set
**gather_facts: false**.

## Example playbook

The path in which the *restoreroot* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`. The VM used has as domain name
**tpl003** (virsh list --all).

```
cat << _EOF_ > restore_root.yml
---

- name: Test restoreroot role
  hosts: all
  gather_facts: false
  roles:
  - role: restoreroot
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' restore_root.yml
```

Run the command again to verify that nothing changes since
the data disk is already prepared in the first run.

```
export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' restore_root.yml
```

## License
GPL License.
