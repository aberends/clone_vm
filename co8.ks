# Use CDROM installation media
cdrom

repo --name="AppStream" --baseurl=file:///run/install/sources/mount-0000-cdrom/AppStream

# Use text install.
text

# Don't run the Setup Agent on first boot.
firstboot --disable

# Keyboard layouts
keyboard --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=static --device=enp1s0 --gateway=192.168.122.1 --ip=192.168.122.201 --nameserver=8.8.8.8,8.8.4.4 --netmask=255.255.255.0 --ipv6=auto --activate
network  --hostname=nuc3-m-co8.tux.m.nuc3.lan

# Root password
rootpw --iscrypted $6$5d16VVhay0dtaRGf$tSRx/cfMo8vq9hAxPfMcc7BAaJBAIvwpgOudWq4L1.6buhxcylnVM.RdhF7h/PArBWO8CviSdT6GRVsyAIlcI/

# System services
#services --enabled="chronyd"
# System timezone
timezone Europe/Amsterdam --utc

# System bootloader configuration.
zerombr
bootloader --location=mbr --boot-drive=vda

ignoredisk --only-use=vda
# Partition clearing information
clearpart --drives=vda --all --initlabel
# Disk partitioning information
part /boot --fstype="xfs" --ondisk=vda --size=512
part pv.157 --fstype="lvmpv" --ondisk=vda --size=4607 --grow
volgroup co8 --pesize=4096 pv.157
logvol /  --fstype="xfs" --size=4092 --name=root --vgname=co8 --grow
logvol swap --fstype="swap" --size=512 --name=swap --vgname=co8
# Poweroff the system to give us a change to persistently
# remove the CDROM.
poweroff

%packages
acpid
bash-completion
cloud-init
cloud-utils-growpart
kexec-tools
mlocate
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
pwpolicy root --minlen=1 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=1 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=1 --minquality=1 --notstrict --nochanges --notempty
%end
