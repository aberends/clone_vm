#!/bin/bash

export ANSIBLE_RETRY_FILES_ENABLED="false"
# AB: note that all tasks are delegated to localhost, so
# tpl003 is not used.
ansible-playbook --inventory tpl003, salted_hash.yml
