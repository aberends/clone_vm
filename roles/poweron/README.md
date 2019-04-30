# Introduction to poweron

The *poweron* role powers on VMs from the local KVM host.

The task is delegated to **localhost** and must be run as
root via sudo. Consequently, the user running the *poweron*
role must have sudo rights to become root.

Since the goal is to bring the specified VMs (the hosts
variable) in state *running* (virsh domstate) the start
state can be *shut off*. Hence the VM is not reachable via
SSH and, consequently, this role must only be called with
**gather_facts: false**.

## Example playbook

The path in which the *poweron* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`. The VM used has as domain name
**tpl003** (virsh list --all). Below, we want to make sure
that **tpl003** is in state *running* (virsh domstate
tpl003).

```
cat << _EOF_ > power_on.yml
---

- name: Test poweron role
  hosts: all
  gather_facts: false
  roles:
  - role: poweron
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' power_on.yml
```

Note that after executing the commands above on the KVM host
with Ansible installed, the **tpl003** VM is switched on.
From this state one can run the last command again:

```
export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' power_on.yml
```

The second time the task runs quickly because the VM is
already *running*.

## License
GPL License.
