#!/bin/bash

# /etc/hosts entry:
# 192.168.122.142  nuc3-m-pgp003.tux.m.nuc3.lan nuc3-m-pgp003

# Input variables.
CDROM_PATH=/var/lib/libvirt/boot/CentOS-8.4.2105-x86_64-dvd1.iso
DESCRIPTION="HAProxy/keepalived cluster node"
DOMAIN=pgp003
HOST_PORTION=142
IMAGES_DIR=/var/lib/libvirt/images
MEMORY=$((2*1024))
DISKSIZE=20
NETWORK_PORTION="192 168 122"
POOL=default
VCPUS=1

# Calculated variables.
#FQDN="nuc3-m-$DOMAIN.tux.m.nuc3.lan"
KICKSTART_PATH=$HOME/clone_vm/$DOMAIN.ks
MAC=$(printf "52:54:%2.2x:%2.2x:%2.2x:%2.2x\n" $NETWORK_PORTION $HOST_PORTION)
VOL=$DOMAIN.qcow2
VOL_PATH=$IMAGES_DIR/$VOL

# <disk type='file' device='disk'>
#   <driver name='qemu' type='qcow2'/>
#   <source file='/var/lib/libvirt/images/zbx001.qcow2' index='2'/>
#   <backingStore/>
#   <target dev='vda' bus='virtio'/>
#   <alias name='virtio-disk0'/>
#   <address type='pci' domain='0x0000' bus='0x04' slot='0x00' function='0x0'/>
# </disk>

# Actions.
virsh destroy $DOMAIN
virsh undefine $DOMAIN
virsh vol-delete $VOL --pool $POOL

virt-install \
  --connect qemu:///system \
  --name=$DOMAIN \
  --memory=$MEMORY \
  --arch=x86_64 \
  --metadata=description="$DESCRIPTION" \
  --vcpus=vcpus=$VCPUS \
  --location=$CDROM_PATH \
  --extra-args="inst.ks=file:/$DOMAIN.ks console=ttyS0,115200 inst.sshd" \
  --initrd-inject=$KICKSTART_PATH \
  --boot=hd \
  --os-variant=centos8 \
  --disk=path=$VOL_PATH,device=disk,format=qcow2,size=$DISKSIZE \
  --network=network=default,mac=$MAC \
  --graphics=none \
  --noautoconsole \
  --hvm \
  --autostart

while [[ "$(virsh domstate $DOMAIN 2>/dev/null)" != "shut off" ]]
do
  echo "Waiting for $DOMAIN to be shut off"
  date
  sleep 2
done

virsh autostart $DOMAIN
virsh start $DOMAIN
