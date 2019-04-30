#!/bin/bash
#
# SCRIPT
#   create_tpl_vm.sh
# DESCRIPTION
# ARGUMENTS
#   None.
# RETURN
#   0: success.
# DEPENDENCIES
# FAILURE
# AUTHORS
#   Date strings made with 'date +"\%Y-\%m-\%d \%H:\%M"'.
#   Allard Berends (AB), 2019-04-22 16:09
# HISTORY
# LICENSE
#   Copyright (C) 2019 Allard Berends
#
#   create_tpl_vm.sh is free software; you can redistribute
#   it and/or modify it under the terms of the GNU General
#   Public License as published by the Free Software
#   Foundation; either version 3 of the License, or (at your
#   option) any later version.
#
#   create_tpl_vm.sh is distributed in the hope that it will
#   be useful, but WITHOUT ANY WARRANTY; without even the
#   implied warranty of MERCHANTABILITY or FITNESS FOR A
#   PARTICULAR PURPOSE. See the GNU General Public License
#   for more details.
#
#   You should have received a copy of the GNU General
#   Public License along with this program; if not, write to
#   the Free Software Foundation, Inc., 59 Temple Place -
#   Suite 330, Boston, MA 02111-1307, USA.
# DESIGN
#
PNAME=$(basename $0)

set | sort > /tmp/b
#
# FUNCTION
#   usage
# DESCRIPTION
#   This function explains how this script should be called
#   on the command line.
# RETURN CODE
#   Nothing
#
usage() {
  echo "Usage: $PNAME"
  echo
  echo " -b <become password>: default 'redhat', if path, reads from it"
  echo " -c <clone vm directory>: default is ~/clone_vm"
  echo " -d <debug value>: 1-4, default is absent"
  echo " -p <ansible password>: default 'redhat', if path, reads from it"
  echo " -s : set to skip ISO check, default is absent"
  echo " -t <template vm name>: default is tpl003"
  echo " -v <volume group>: storage pool VG, default is system VG"
  echo " -h : this help message"
  echo
} # end usage

#
# FUNCTION
#   options
# DESCRIPTION
#   This function parses the command line options.
#   If an option requires a parameter and it is not
#   given, this function exits with error code 1, otherwise
#   it succeeds. Parameter checking is done later.
# EXIT CODE
#   1: error
#
options() {
  # Assume correct processing
  RC=0

  while getopts "b:c:d:p:st:v:h" Option 2>/dev/null
  do
    case $Option in
    b)  B_OPTION=$OPTARG ;;
    c)  C_OPTION=$OPTARG ;;
    d)  D_OPTION=$OPTARG ;;
    p)  P_OPTION=$OPTARG ;;
    s)  S_OPTION="yes" ;;
    t)  T_OPTION=$OPTARG ;;
    v)  V_OPTION=$OPTARG ;;
    ?|h|-h|-help)  usage
        exit 0 ;;
    *)  usage >&2
        exit 1 ;;
    esac
  done

  shift $(($OPTIND-1))
  ARGS=$@
} # end options

#
# FUNCTION
#   verify
# DESCRIPTION
#   This function verifies the parameters obtained from
#   the command line.
# EXIT CODE
#   2: error
#
verify() {
  # Verify B_OPTION
  if [[ -n "$B_OPTION" ]]; then
    if [[ -s "$B_OPTION" ]]; then
      B_OPTION=$(head -1 "$B_OPTION")
    fi
    B_OPTION=" ansible_become_pass=${B_OPTION}"
  else
    B_OPTION=" ansible_become_pass=redhat"
  fi

  # Verify C_OPTION
  if [[ -n "$C_OPTION" ]]; then
    if [[ ! -d "$C_OPTION" ]]; then
      echo "The -c option must be a directory" >&2
      echo >&2
      exit 1
    fi
    C_OPTION=" create_tpl_vm_dir=$C_OPTION"
  else
    C_OPTION=""
  fi

  # Verify D_OPTION
  if [[ -z "$D_OPTION" ]]; then
    D_OPTION=""
  else
    if [[ $D_OPTION -lt 1 || $D_OPTION -gt 4 ]]; then
      echo "The -d option must be in range [1, 4]" >&2
      echo >&2
      exit 1
    fi
    D_OPTION=" -$(while [[ $D_OPTION -gt 0 ]]; do echo -n v; D_OPTION=$(($D_OPTION - 1)); done)"
  fi

  # Verify P_OPTION
  if [[ -n "$P_OPTION" ]]; then
    if [[ -s "$P_OPTION" ]]; then
      P_OPTION=$(head -1 "$P_OPTION")
    fi
    P_OPTION=" ansible_ssh_pass=${P_OPTION}"
  else
    P_OPTION=" ansible_ssh_pass=redhat"
  fi

  # Verify S_OPTION
  if [[ -n "$S_OPTION" ]]; then
    S_OPTION=" create_tpl_vm_skip_iso_check=true"
  else
    S_OPTION=""
  fi

  # Verify T_OPTION
  if [[ -z "$T_OPTION" ]]; then
    T_OPTION="tpl003"
  else
    # AB: the convention for the domain is to end with a
    # number in the range of 2-254 with preceding 0's to
    # fill up 3 positions. The number is used as the last
    # octet in the class C network.
    OCTET=$(echo $T_OPTION | sed 's/^[a-z0-9]*[a-z]\([0-9]\+\)$/\1/' | sed 's/0\+//')
    if [[ -z "$OCTET" || $OCTET -lt 2 || $OCTET -gt 254 ]]; then
      echo "The -d option must match '^[a-z0-9]*[a-z][0-9]\+$'." >&2
      echo
      exit 1
    fi
  fi

  # Verify V_OPTION
  if [[ -n "$V_OPTION" ]]; then
    V_OPTION=" create_tpl_vm_vg=${V_OPTION}"
  else
    V_OPTION=""
  fi
  # AB: the VG is checked by the preparekvm role.
} # end verify

# Get command line options.
options $*

# Verify command line options.
verify

if [[ -n "$D_OPTION" ]]; then
  echo "$PNAME given command line options:"
  echo $B_OPTION
  echo $C_OPTION
  echo $D_OPTION
  echo $P_OPTION
  echo $T_OPTION
  echo $V_OPTION
  echo "end $PNAME given command line options"
fi

#ANSIBLE_NOCOLOR=1
# AB: note that although we use "--user" to tell ansible to
# run with the root account when connecting to target
# machine, ansible itself runs under the user which is used
# to start this script. So environment variables, paths,
# etc. are relative to the user under which ansible is run
# if delegate to the localhost.
export ANSIBLE_HOST_KEY_CHECKING="false"
export ANSIBLE_RETRY_FILES_ENABLED="false"
echo ansible-playbook --user root --inventory=$T_OPTION, --extra-vars "${C_OPTION}${V_OPTION}${P_OPTION}${B_OPTION}${S_OPTION}" create_tpl_vm.yml${D_OPTION}
ansible-playbook --user root --inventory=$T_OPTION, --extra-vars "${C_OPTION}${V_OPTION}${P_OPTION}${B_OPTION}${S_OPTION}" create_tpl_vm.yml${D_OPTION}
