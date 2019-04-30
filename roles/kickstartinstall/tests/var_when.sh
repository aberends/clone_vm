#!/bin/bash

export ANSIBLE_RETRY_FILES_ENABLED="false"
# AB: the hostname tpl003 is used to calculate the MAC
# address.
ansible-playbook --inventory tpl003, var_when.yml

# AB: the hostname tpl503 is illegal because the 503 part is
# used as the last octet of the IPv4 address. It must be in
# the range [2, 254] inclusive.
ansible-playbook --inventory tpl503, var_when.yml
