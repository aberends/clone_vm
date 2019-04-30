# Introduction to cleanupvm

The *cleanupvm* role removes the VM and its disks from the
KVM host.

The task is delegated to **localhost** and must be run as
root via sudo. Consequently, the user running the *cleanupvm*
role must have sudo rights to become root.

Since the goal is to cleanup the VM we must not obtain facts
about it and we set **gather_facts: false**.

## Example playbook

The path in which the *cleanupvm* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`. The VM used has as domain name
**tpl003** (virsh list --all). Below, we want to make sure
that **tpl003** is undefined.

```
cat << _EOF_ > cleanup_vm.yml
---

- name: Test cleanupvm role
  hosts: all
  gather_facts: false
  roles:
  - role: cleanupvm
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat cleanupvm_vg=fedora' cleanup_vm.yml
```

Run the command again to verify that no more changes occur.

```
export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat cleanupvm_vg=fedora' cleanup_vm.yml
```

## Extra variables

The role has a number of configurable parameters.

### cleanupvm\_vg

The role depends on the variable *preparekvm_vg_info* coming
from the role preparekvm. It can also be set manually:

```
--extra-vars 'cleanupvm_vg=fedora'
```

## License
GPL License.
