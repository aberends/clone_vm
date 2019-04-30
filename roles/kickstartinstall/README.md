# Introduction to kickstartinstall

The *kickstartinstall* role installs the VM on the KVM host
based on the information in the kickstart file.

The task is delegated to **localhost** and must be run as
root via sudo. Consequently, the user running the
*kickstartinstall* role must have sudo rights to become root.

Since the VM does not exist we must not obtain facts about
it and we set **gather_facts: false**.

## Example playbook

The path in which the *kickstartinstall* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`. The VM used has as domain name
**tpl003** (virsh list --all).

```
cat << _EOF_ > kickstart_install.yml
---

- name: Test kickstartinstall role
  hosts: all
  gather_facts: false
  roles:
  - role: kickstartinstall
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' kickstart_install.yml
```

Run the command again to verify that it fails. The VM is
already present and can not be created while existing.

```
export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' kickstart_install.yml
```

## Extra variables

### kickstartinstall\_clone\_vm\_dir

The default value is ~/clone\_vm.

### kickstartinstall\_iso\_pattern

The default value is \*-x86\_64-Minimal-\*.iso. It is used
to match the ISO file via a shell glob pattern. If a
different ISO is used, this pattern might need change.

### kickstartinstall\_vg

The default value is calculated. Normally it should be left
at the default, unless one wants to use a different VG.

## License
GPL License.
