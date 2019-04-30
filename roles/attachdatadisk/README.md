# Introduction to attachdatadisk

The *attachdatadisk* role attaches the data disk
/dev/VG/dDOMAIN to the VM.

The task is delegated to **localhost** and must be run as
root via sudo. Consequently, the user running the
*attachdatadisk* role must have sudo rights to become root.

Since the goal is to attach a data disk we don't need to
obtain facts and we set **gather_facts: false**.

## Example playbook

The path in which the *attachdatadisk* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`. The VM used has as domain name
**tpl003** (virsh list --all).

```
cat << _EOF_ > attach_data_disk.yml
---

- name: Test attachdatadisk role
  hosts: all
  gather_facts: false
  roles:
  - role: attachdatadisk
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' attach_data_disk.yml
```

Run the command again to verify that nothing changes since
the data disk is already attached in the first run.

```
export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' attach_data_disk.yml
```

## Extra variables

The role has a number of configurable parameters.

### attachdatadisk\_vg

The default value is calculated by an algorithm and defaults
to the system VG.

## License
GPL License.
