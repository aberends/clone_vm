# Introduction to makebindmounts

The *makebindmounts* role creates the bind mount points and
bind mounts the different memory filesystems on it in order
to be able to chroot to the restored root filesystem.

Since we don't need facts about the VM we set
**gather_facts: false**.

## Example playbook

The path in which the *makebindmounts* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`. The VM used has as domain name
**tpl003** (virsh list --all).

```
cat << _EOF_ > make_bind_mounts.yml
---

- name: Test makebindmounts role
  hosts: all
  gather_facts: false
  roles:
  - role: makebindmounts
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' make_bind_mounts.yml
```

Run the command again to verify that nothing changes since
the data disk is already prepared in the first run.

```
export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' make_bind_mounts.yml
```

## License
GPL License.
