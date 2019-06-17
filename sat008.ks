#version=DEVEL
# System authorization information
auth --enableshadow --passalgo=sha512
repo --name="Server-HighAvailability" --baseurl=file:///run/install/repo/addons/HighAvailability
repo --name="Server-ResilientStorage" --baseurl=file:///run/install/repo/addons/ResilientStorage
# Use CDROM installation media
cdrom
# Use text install.
text
# Don't run the Setup Agent on first boot.
firstboot --disable
ignoredisk --only-use=vda
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network --bootproto=static --device=eth0 --gateway=192.168.122.1 --ip=192.168.122.8 --nameserver=8.8.4.4,8.8.8.8 --netmask=255.255.255.0 --ipv6=auto --activate
network --hostname=sat008.home.org

# Root password
rootpw --iscrypted $6$VqpnR1p7fX77VP1I$y2bB8RshiFXMAgzHed4RIaZUR1ny8GnXGCCw8uHRItsvx/xsnqsx0X/YMwIuRfKKmBQ5FCeTUkP9mnXDzri9u1
# System services
services --enabled="chronyd"
# System timezone
timezone Europe/Amsterdam --isUtc --nontp
# System bootloader configuration.
zerombr
bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=vda
# Partition clearing information
clearpart --drives=vda --all --initlabel
# Disk partitioning information
part /boot --fstype="xfs" --ondisk=vda --size=1024
part pv.157 --fstype="lvmpv" --ondisk=vda --size=4607 --grow
volgroup os --pesize=4096 pv.157
logvol /  --fstype="xfs" --size=4092 --name=root --vgname=os --grow
logvol swap  --fstype="swap" --size=511 --name=swap --vgname=os
# Poweroff the system to give us a change to persistently
# remove the CDROM.
poweroff

%packages
@^minimal
@core
kexec-tools
bash-completion
mlocate
tcpdump
telnet
tree
vim-enhanced
wget
%end

%addon com_redhat_kdump --enable --reserve-mb='auto'
%end

%post --log=/root/ks-post.log
echo post log test
%end

%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --notempty
%end
