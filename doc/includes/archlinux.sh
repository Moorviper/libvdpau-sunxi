#
#  Install Archlinux and VDR
#


# prepare the sd card

fdisk /dev/<device>


# in fdisk

press o to kill all part
press n <enter> (several times)
press w to finish



# format the Partition with ext4 and mount it to /mnt/:

mkfs.ext4 /dev/<device>
mount /dev/<device> /mnt/



#Get the Arch-Linux-Base-Image:

cd /usr/local/src/
wget http://os.archlinuxarm.org/os/ArchLinuxARM-sun7i-latest.tar.gz
tar -xvf ArchLinuxARM-sun7i-latest.tar.gz -C /mnt/
sync



# Next we have to install the U-Boot bootloader so the Cubieboard2 boots up properly:

dd if=/mnt/boot/u-boot-sunxi-with-spl.bin of=/dev/<device> bs=1024 seek=8
sync



# Unmount the SD-Card

umount /mnt/


# Put the SD-Card in Cubieboard

apt-get install gtkterm


# open it

gtkterm -p /dev/ttyUSB0 -s 115200

# login  user/password for ArchLinux

User:  root
Pass:  root

#
# On Cubieboard
#

# Setting up Hostname:

nano /etc/hostname

# save

<ctrl>+<shift>+<o>

#Setup locales: ( unmark the language you want!!!)

nano /etc/locale.gen

# and apply it

locale-gen

# Setup network via DHCP (The writer uses static DHCP)

 cp /etc/netctl/examples/ethernet-dhcp /etc/netctl/
 netctl enable ethernet-dhcp 

#Activate hdmi-output

nano /etc/modules-load.d/sunxi_cedar_mod.conf

# with following content:

# load sunxi cedar module
sunxi_cedar_mod
lcd
hdmi
ump
disp
mali
mali_drm
cedar_dev
bt_gpio
bcmdhd
sw_ahci_platform 


#
# Reboot
#

reboot

# Update Packages and System:

pacman -Syu

# Setup X-Server

pacman -S xorg-server xorg-xinit xterm mate-desktop onboard mate-utils wget

# and install some packages

pacman -S xorg-server xf86driproto xorg-util-macros xorg-server-devel \
git base-devel xf86-video-fbturbo-git


# Get the Kernel Source for 3.4.90 and copy config which is used by Arch:

cd /usr/src
wget https://github.com/linux-sunxi/linux-sunxi/asunxi-v3.4.90-r1.tar.gz
tar xfvz sunxi-v3.4.90-r1.tar.gz 
ln -s linux-sunxi-sunxi-v3.4.90-r1/ linux
cd linux 
rm .config
cp /proc/config.gz /usr/src/
gunzip config.gz
cd linux
cp ../config .config
make clean
make oldconfig


# Fix cedarX Memory-Reservation:

nano drivers/media/video/sunxi/sunxi_cedar.c

// To jump on line
<strg>w <strg>t 931
ve_size auf 180 (von 80MB)


# ------------------------------------------------------
# or disable CMA

CONFIG_CMA=y

change to:

+#  CONFIG_CMA is not set 

# ------------------------------------------------------
# Compile Kernel:

make -j2 uImage modules 
make  INSTALL_MOD_PATH=output modules_install

#
#	get and build libvdpau
#

# get the source:

cd /usr/local/src
git clone https://github.com/linux-sunxi/libvdpau-sunxi.git
cd libvdpau-sunxi/
make clean
make
make install


# to use sunxi-vdpau you need to make some exports and chmod's

export VDPAU_DRIVER=sunxi;
export DISPLAY=:0.0;
export VDPAU_OSD=1;
chmod 0777 /dev/disp; 
chmod 0777 /dev/cedar_dev; 


