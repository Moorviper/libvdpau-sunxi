#!/bin/sh
export LC_MESSAGES=de_DE.UTF-8
export LC_LANG=de_DE.UTF-8
export VDPAU_DRIVER=sunxi;
export DISPLAY=:0.0;
export VDPAU_OSD=1;
export VDPAU_DEINT=1;

chmod 0777 /dev/disp;
chmod 0777 /dev/cedar_dev;
chmod 0777 /dev/g2d;

/usr/local/bin/vdr -d -l 2 -P streamdev-client -P"softhddevice -x -a sunxihdmi"