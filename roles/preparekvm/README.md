# Introduction to preparekvm

The *preparekvm* role makes sure that the right software is
available and determines if we can find suitable VG on the
host to create the template VM on.

The tasks are delegated to **localhost** and are be run
under a normal account and under root via sudo.
Consequently, the user running the *preparekvm* role must
have sudo rights to become root.

Since some tasks are run under a normal account the play
should not specify become when this role is called.
Gathering facts should not be done either because in this
role facts are gathered using become to obtain all system
information with respect to LVM2. Consequently, for
efficiency, this role should only be called with
**gather_facts: false**.

## Example playbook

The path in which the *preparekvm* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`. The VM used has as domain
name **tpl003** (virsh list --all).

```
cat << _EOF_ > prepare_kvm.yml
---

- name: Test preparekvm role
  hosts: all
  gather_facts: false
  roles:
  - role: preparekvm
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
TESTDOMAIN=tpl003
ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' prepare_kvm.yml
```

Note that the *tpl003* VM is not used since all tasks are
delegate to **localhost**.

## Extra variables

The role has a number of configurable parameters.

### preparekvm\_clone\_vm\_dir

The default value `~/clone_vm` assumes that `roles` is a
direct subdirectory. If this is not the case, for example
when the source is cloned into another directory, the
*preparekvm_clone_vm_dir* variable must be pointed to the
other directory, e.g.:

```
--extra-vars 'preparekvm_clone_vm_dir=~/other/dir'.
```

### preparekvm\_min\_gib

The default value of `9` is based upon the following
calculation:

- 4 GiB for the minimal install
- 2 GiB for the xfsdump of / and /boot
- 2 GiB as a maximum for condensed / and /boot
- 1 GiB maneuver space

Since we lose some space to LVM2 and XFS we add the 1 GiB.
If the calculations are off, the value for
*preparekvm_min_gib* can be adapted with, say:

```
--extra-vars 'preparekvm_min_gib=12'
```

### preparekvm\_user\_specified\_vg

The algorithm chooses the distribution VG, e.g. centos, if
it has enough space. If the user want to use another VG it
can be set with *preparekvm_user_specified_vg* like:

```
--extra-vars 'preparekvm_user_specified_vg=vm'
```

## License
GPL License.
