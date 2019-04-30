# Introduction to poweroff

The *poweroff* role aims to power off VM's from the local
KVM host.

The task is delegated to **localhost** and must be run as
root via sudo. Consequently, the user running the *poweroff*
role must have sudo rights to become root.

Since the goal is to bring the specified VM's (the hosts
variable) in state *shut off* (virsh domstate) the start
state can already be *shut off*. Hence the VM is not
reachable via SSH and, consequently, this role must only be
called with **gather_facts: false**.

## Example playbook

The path in which the *poweroff* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`. The VM used has as domain name
**tpl003** (virsh list --all). Below, we want to make sure
that **tpl003** is in state *shut off* (virsh domstate
tpl003).

```
cat << _EOF_ > power_off.yml
---

- name: Test poweroff role
  hosts: all
  gather_facts: false
  roles:
  - role: poweroff
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' power_off.yml

```

Note that after executing the commands above on the KVM host
with Ansible installed, the **tpl003** VM is switched off.
From this state one can run the last command again:

```
export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' power_off.yml

```

The second time the task runs quickly because the VM is
already *shut off*, at least if before the first execution
the VM was running.

## License
GPL License.

