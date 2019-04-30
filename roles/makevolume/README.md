# Introduction to makevolume

The *makevolume* role creates the VM disk from the KVM host.

The task is delegated to **localhost** and must be run as
root via sudo. Consequently, the user running the
*makevolume* role must have sudo rights to become root.

Since the goal is to create the VM disk it is useless in
this phase to obtain facts about the VM and we set
**gather_facts: false**.

## Example playbook

The path in which the *makevolume* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`. The VM used has as domain name
**tpl003** (virsh list --all). Below, we want to make sure
that **tpl003** volume is created under /dev/VG. VG is
either specified directly or discovered in another role.

```
cat << _EOF_ > make_volume.yml
---

- name: Test makevolume role
  hosts: all
  gather_facts: false
  roles:
  - role: makevolume
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' make_volume.yml
```

Run the command again to verify that no more changes occur.

```
export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' make_volume.yml
```

## Extra variables

The role has a number of configurable parameters.

### makevolume\_vg

Use this parameter to manually specify the VG to be used.

### makevolume\_size

This parameter should normally not be changed. It is set to
a default value that is sufficient for a minimal install.

## License
GPL License.
