# Introduction to testssh

The *testssh* role verifies if the VM is reachable from the
local KVM host via SSH.

The task is delegated to **localhost**.

Since the VM can be starting up, it might take a while
before the SSH connection is up. So, it might be impossible
to gather facts from the host. Gathering facts from the KVM
host is not useful, so this role must only be called with
**gather_facts: false**.

## Example playbook

The path in which the *testssh* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`. The VM used has as domain name
**tpl003** (virsh list --all).

```
cat << _EOF_ > test_ssh.yml
---

- name: Test testssh role
  hosts: all
  gather_facts: false
  roles:
  - role: testssh
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' test_ssh.yml
```

## Extra variables

The role has a number of configurable parameters.

### testssh\_timeout\_in\_s

The default value is set to 20s, which is enough for a small
VM with minimal distribution installed on it to boot and
start sshd. Change it if longer (or shorter) times are
needed.

## License
GPL License.
