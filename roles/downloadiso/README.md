# Introduction to downloadiso

The *downloadiso* role downloads the distribution Minimal
installation ISO from the distribution site onto the KVM
host.

The task is delegated to **localhost** and is run under a
local user account. For this role no extra privileges are
needed.

Since the goal is to download an ISO we don't need facts and
we set **gather_facts: false**.

## Example playbook

The path in which the *downloadiso* role is installed in:
`/USER/HOMEDIR/clone_vm/roles`. The hosts variable is
irrelevant for this role since all tasks are delegated to
localhost.

```
cat << _EOF_ > download_iso.yml
---

- name: Test downloadiso role
  hosts: all
  gather_facts: false
  roles:
  - role: downloadiso
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
# AB: dummy test domain. Is not used in this role.
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, download_iso.yml
```

Run the command again to verify that it does not do anything
since the ISO is now present.

```
export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
# AB: dummy test domain. Is not used in this role.
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, download_iso.yml
```

## Extra variables

The role has a number of configurable parameters.

### downloadiso\_clone\_vm\_dir

The default value `~/clone_vm` assumes that `roles` is a
direct subdirectory. If this is not the case, for example
when the source is cloned into another directory, the
*preparekvm_clone_vm_dir* variable must be pointed to the
other directory, e.g.:

```
--extra-vars 'preparekvm_clone_vm_dir=~/other/dir'.
```

### downloadiso\_distribution\_url

The default value `https://www.centos.org/download/` is used
to setup CentOS7.

If a template of another distribution is wanted then this

```
--extra-vars 'downloadiso_distribution_url="https://getfedora.org/en/server/download/"'
```

### downloadiso\_iso\_pattern

The fnmatch(3) shell glob pattern matching the ISO file in
the *downloadiso_clone_vm_dir* directory.

```
--extra-vars 'downloadiso_iso_pattern: "Fedora-Server-dvd-x86_64-29-*.iso"'
```

### downloadiso\_url\_pattern

The BRE pattern matching the download URL on the web page
pointed to by *downloadiso_distribution_url*.

```
--extra-vars 'downloadiso_url_pattern="https://.*Fedora-Server-dvd-x86_64-29-.*\.iso"'
```

## License
GPL License.
