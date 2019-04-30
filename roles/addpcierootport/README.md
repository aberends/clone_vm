# Introduction to addpcierootport

The *addpcierootport* role determines if KVM uses the new
machine type pc-q35. If so, an extra pcie-root-port is added
to the list of controllers of the VM.

The task is delegated to **localhost** and must be run as
root via sudo. Consequently, the user running the
*addpcierootport* role must have sudo rights to become root.

Since the VM is supposed to be "shut off" we must not obtain
facts about it and we set **gather_facts: false**.

## Example playbook

The path in which the *addpcierootport* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`. The VM used has as domain name
**tpl003** (virsh list --all).

```
cat << _EOF_ > add_pcie_root_port.yml
---

- name: Test addpcierootport role
  hosts: all
  gather_facts: false
  roles:
  - role: addpcierootport
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' add_pcie_root_port.yml
```

Run the command again to verify that no more changes occur.

```
export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' add_pcie_root_port.yml
```

## License
GPL License.
