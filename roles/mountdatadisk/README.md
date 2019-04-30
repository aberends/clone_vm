# Introduction to mountdatadisk

The *mountdatadisk* role mounts the data disk on the mount
point.

Since we don't need facts about the VM and we set
**gather_facts: false**.

## Example playbook

The path in which the *mountdatadisk* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`. The VM used has as domain name
**tpl003** (virsh list --all).

```
cat << _EOF_ > mount_data_disk.yml
---

- name: Test mountdatadisk role
  hosts: all
  gather_facts: false
  roles:
  - role: mountdatadisk
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' mount_data_disk.yml
```

Run the command again to verify that nothing changes since
the data disk has already been mounted in the first run.

```
export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' mount_data_disk.yml
```

## License
GPL License.
