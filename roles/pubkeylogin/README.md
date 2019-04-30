# Introduction to pubkeylogin

The *pubkeylogin* role enables passwordless login as root on
the target VM.

It checks if the user has an SSH keypair. If not, it is
created on the **localhost**.

In order to run the role,
*ANSIBLE_HOST_KEY_CHECKING="false"* must be set as
environment variable and it must be exported so that
subsequent commands, i.e. ansible-playbook, knows about the
setting.

In the playbook *gather_facts* should be set to *false*. The
only thing we do is placing the SSH pubkey on the VM, so no
other facts are needed.

## Example playbook

The path in which the *pubkeylogin* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`. The VM used is
**tpl003.home.org**.

```
cat << _EOF_ > pubkey_login.yml
---

- name: Test pubkeylogin role
  hosts: all
  gather_facts: false
  roles:
  - role: pubkeylogin
_EOF_

export ANSIBLE_HOST_KEY_CHECKING="false"
export ANSIBLE_RETRY_FILES_ENABLED="false"
export ANSIBLE_ROLES_PATH="../../../roles"
TESTDOMAIN=tpl003.home.org
ansible-playbook --user=root --inventory=$TESTDOMAIN, --extra-vars 'ansible_ssh_pass=redhat' pubkey_login.yml
```

After executing the commands above on the user on the KVM
host owns an SSH keypair and the SSH public key is copied
into the ~/.ssh/authorized_keys file of root.

If the ~/.ssh/known_hosts file of the user did not contain
the SSH host key of the VM, then it is automatically added.

Running the test again should not change anything.

```
export ANSIBLE_HOST_KEY_CHECKING="false"
export ANSIBLE_RETRY_FILES_ENABLED="false"
export ANSIBLE_ROLES_PATH="../../../roles"
TESTDOMAIN=tpl003.home.org
ansible-playbook --user=root --inventory=$TESTDOMAIN, --extra-vars 'ansible_ssh_pass=redhat' pubkey_login.yml
```

## License
GPL License.
