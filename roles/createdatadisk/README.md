# Introduction to createdatadisk

The *createdatadisk* role detaches the data disk from a
domain when it is still attached to one. Next, a new data
disk is created and it is attached to the VM(s).

The task is delegated to **localhost** and must be run as
root via sudo. Consequently, the user running the
*createdatadisk* role must have sudo rights to become root.

Since the goal is to create a data disk we don't need to
obtain facts and we set **gather_facts: false**.

## Example playbook

The path in which the *createdatadisk* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`. The VM used has as domain name
**tpl003** (virsh list --all).

```
cat << _EOF_ > create_data_disk.yml
---

- name: Test createdatadisk role
  hosts: all
  gather_facts: false
  roles:
  - role: createdatadisk
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' create_data_disk.yml
```

Run the command again to verify that only the removal of the
old data disk occurs and the creation of the new one.

```
export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' create_data_disk.yml
```

## Extra variables

The role has a number of configurable parameters.

### createdatadisk\_vg

The default value is determined by an algorithm and defaults
to the system VG.

## License
GPL License.
