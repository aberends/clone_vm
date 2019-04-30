# Introduction to definedvar

The *definedvar* role is used to test how the mechanism of
defining a variable works in Ansible.

## Example playbook

The path in which the *definedvar* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`.

```
cat << _EOF_ > defined_var.yml
---

- name: Test definedvar role
  hosts: all
  roles:
  - role: definedvar
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=localhost
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' defined_var.yml

```

Run the last command again with an extra var:

```
export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=localhost
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat definedvar_test=new_value' defined_var.yml

```

The second time the task runs the output shows a different
value for the variable.

## License
GPL License.
