# Introduction to preparetemplatedisk

The *preparetemplatedisk* role prepares the template disk by
creating partitions on it and XFS filesystems.

Since we are not interested in facts about the VM we set
**gather_facts: false**.

## Example playbook

The path in which the *preparetemplatedisk* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`. The VM used has as domain name
**tpl003** (virsh list --all).

```
cat << _EOF_ > prepare_template_disk.yml
---

- name: Test preparetemplatedisk role
  hosts: all
  gather_facts: false
  roles:
  - role: preparetemplatedisk
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' prepare_template_disk.yml
```

Run the command again to verify that nothing changes since
the data disk is already prepared in the first run.

```
export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' prepare_template_disk.yml
```

## Extra variables

The role has a number of configurable parameters.

### preparetemplatedisk\_boot\_size\_mib

The default value is calculated by the createtemplatedisk
role. If not correct, change it here by giving the amount of
MiB needed.

## License
GPL License.
