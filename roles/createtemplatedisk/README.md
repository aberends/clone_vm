# Introduction to createtemplatedisk

The *createtemplatedisk* role detaches the template disk
from a domain when it is still attached to one. Next, a new
template disk is created and it is attached to the VM(s).

The task is delegated to **localhost** and must be run as
root via sudo. Consequently, the user running the
*createtemplatedisk* role must have sudo rights to become
root.

## Example playbook

The path in which the *createtemplatedisk* role is installed
is: `/USER/HOMEDIR/clone_vm/roles`. The VM used has as domain
name **tpl003** (virsh list --all).

```
cat << _EOF_ > create_template_disk.yml
---

- name: Test createtemplatedisk role
  hosts: all
  gather_facts: false
  roles:
  - role: createtemplatedisk
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' create_template_disk.yml
```

Run the command again to verify that only the removal of the
old template disk occurs and the creation of the new one.

```
export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' create_template_disk.yml
```

## Extra variables

The role has a number of configurable parameters.

### createtemplatedisk\_add\_boot\_mb

The default value is 20 MiB. For the boot partition this is
enough space to maneuvre. If it is insufficient, increase
the value by setting this parameter.

### createtemplatedisk\_add\_root\_mb

The default value is 100 MiB. For the root partition this is
enough space to maneuvre. If it is insufficient, increase
the value by setting this parameter.

### createtemplatedisk\_vg

The default value is determined by an algorithm and defaults
to the system VG.

## License
GPL License.
