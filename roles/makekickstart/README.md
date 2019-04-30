# Introduction to makekickstart

The *makekickstart* role creates the kickstart file needed
to install the VM with virt-install from the KVM host.

The tasks are delegated to **localhost** and run under a
normal account.

Since the VM does not exist yet, we don't obtain facts about
it and we set **gather_facts: false**.

## Example playbook

The path in which the *makekickstart* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`.

```
cat << _EOF_ > make_kickstart.yml
---

- name: Test makekickstart role
  hosts: all
  connection: local
  gather_facts: false

  roles:
  - role: makekickstart
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars make_kickstart.yml
```

Run the command again to verify that no more changes occur.

```
export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, make_kickstart.yml
```

## Extra variables

The role has a number of configurable parameters.

### makekickstart\_clone\_vm\_dir

The default value is set to ~/clone\_vm.

### makekickstart\_ipv4

The IPv4 address used by the VM. The default value uses the
192.168.122.0/24 subnet wich corresponds to the *default*
network of KVM. The last octet is obtained from the VM
hostname. For example tpl003 yields the IPv4 address
192.168.122.3.

### makekickstart\_path

Location of the kickstart file. The default location is in
the ~/clone\_vm directory.

### makekickstart\_root\_pw

To set the root password in the kickstart file use this
parameter. Note that the default value is redhat. If a value
for ansible\_ssh\_pass is given, it is the default.

### makekickstart\_timezone

By default this parameter is not set. The role therefore
obtains the timezone from the KVM host. If the timezone
needs to be different set it here.

```
--extra-vars 'makekickstart_timezone=Europe/Amsterdam'
```

The specified timezone is tested agains the output of
*timedatectl list-timezones | grep Europe/Amsterdam*

## License
GPL License.
