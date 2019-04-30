# Introduction to preparedatadisk

The *preparedatadisk* role prepares the data disk by
creating one partition on it and then creating an XFS
filesystem on the partition.

Since the partition information is obtained via the parted
module, we don't need to gather facts about the VM and we
set **gather_facts: false**.

## Example playbook

The path in which the *preparedatadisk* role is installed in:
`/USER/HOMEDIR/clone_vm/roles`. The VM used has as domain name
**tpl003** (virsh list --all).

```
cat << _EOF_ > prepare_data_disk.yml
---

- name: Test preparedatadisk role
  hosts: all
  gather_facts: false
  roles:
  - role: preparedatadisk
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' prepare_data_disk.yml
```

Run the command again to verify that nothing changes since
the data disk is already prepared in the first run.

```
export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' prepare_data_disk.yml
```

## License
GPL License.
