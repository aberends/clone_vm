# Introduction to configuresystemdisk

The *configuresystemdisk* role configures a number of files
on the system disk to make sure that the template system can
boot.

We are not interested in the facts of the VM so we set
**gather_facts: false**.

## Example playbook

The path in which the *configuresystemdisk* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`. The VM used has as domain name
**tpl003** (virsh list --all).

```
cat << _EOF_ > configure_system_disk.yml
---

- name: Test configuresystemdisk role
  hosts: all
  gather_facts: false
  roles:
  - role: configuresystemdisk
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' configure_system_disk.yml
```

Run the command again to verify that nothing changes since
the data disk is already prepared in the first run.

```
export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' configure_system_disk.yml
```

## License
GPL License.
