# Introduction to isochanged

The *isochanged* role works in concert with the downloadiso
role. It checks if the ISO has changed due to a download. If
no ISO was downloaded this role ends the play.

The purpose of this role is to avoid doing work twice.

The task is delegated to **localhost** and is run under a
local user account. No privileges are needed.

Since the goal is to detect if the ISO has changed and to
stop the play if no change is detected, we don't need facts
and we set **gather_facts: false**.

## Example playbook

The path in which the *isochanged* role is installed is:
`/USER/HOMEDIR/clone_vm/roles`. The hosts variable is
irrelevant for this role since only localhost is used.

```
cat << _EOF_ > iso_changed.yml
---

- name: Test isochanged role with ISO changed
  hosts: all
  gather_facts: false
  vars:
    download_iso_info:
      changed: true
  tasks:
    - name: Some dummy before task
      debug:
        msg: "dummy before task"

    - name: Test isochanged role with ISO changed
      import_role:
        name: isochanged

    - name: Some dummy after task
      debug:
        msg: "dummy after task"
_EOF_

cat << _EOF_ > iso_unchanged.yml
---

- name: Test isochanged role with ISO unchanged
  hosts: all
  gather_facts: false
  vars:
    download_iso_info:
      changed: false
  tasks:
    - name: Some dummy before task
      debug:
        msg: "dummy before task"

    - name: Test isochanged role with ISO unchanged
      import_role:
        name: isochanged

    - name: Some dummy after task that is never executed
      debug:
        msg: "dummy after task that is never executed"
_EOF_

export ANSIBLE_ROLES_PATH="/USER/HOMEDIR/clone_vm/roles"
export ANSIBLE_RETRY_FILES_ENABLED="false"
# AB: dummy test domain. Is not used in this role.
TESTDOMAIN=tpl003

ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' iso_changed.yml

ansible-playbook --inventory=$TESTDOMAIN, --extra-vars 'ansible_become_pass=redhat' iso_unchanged.yml
```

## Extra variables

The role has a number of configurable parameters.

### isochanged_skip

The default value is false. This means that the check is not
skipped.

## License
GPL License.
