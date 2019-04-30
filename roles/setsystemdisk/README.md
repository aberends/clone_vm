# Introduction to setsystemdisk

The *setsystemdisk* role changes the system disk of the VM
to the template disk and removes the original system disk
and the data disk.

The task is delegated to **localhost** and must be run as
root via sudo. Consequently, the user running the
*setsystemdisk* role must have sudo rights to become root.

Since this role is supposed to run when the VM is "shut
off", we don't need to obtain facts about it and we set
**gather_facts: false**.

## Example playbook

The path in which the *setsystemdisk* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`. The VM used has as domain name
**tpl003** (virsh list --all).

```
cat << _EOF_ > set_system_disk.yml
---

- name: Test setsystemdisk role
  hosts: all
  gather_facts: false
  roles:
  - role: setsystemdisk
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' set_system_disk.yml
```

Run the command again to verify that no more changes occur.

```
export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' set_system_disk.yml
```

## Extra variables

The role has a number of configurable parameters.

### setsystemdisk\_vg

The default value is determined by an algorithm and normally
yields the system VG.

## License
GPL License.
