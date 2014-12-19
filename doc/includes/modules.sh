#
#		Module eintragen
#

nano /etc/modules


# /etc/modules: kernel modules to load at boot time.
#
# This file contains the names of kernel modules that should be loaded
# at boot time, one per line. Lines beginning with "#" are ignored.

#For SATA Support
sw_ahci_platform

#Display and GPU
lcd
hdmi
ump
disp
mali
mali_drm
cedar_dev
bt_gpio
bcmdhd



# ----------------------------------------------------------------------------------------------------------------------------