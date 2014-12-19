# xf86 driver installation

cd /usr/local/src/
git clone https://github.com/ssvb/xf86-video-fbturbo.git
cd xf86-video-fbturbo
autoreconf -vi
./configure --prefix=/usr
make -j3
make install
cp xorg.conf /etc/X11

# FFmpeg installation

cd /usr/local/src/
wget http://ffmpeg.org/releases/ffmpeg-2.4.4.tar.bz2 
tar xfvj ffmpeg-2.4.4.tar.bz2
cd ffmpeg-2.4.4
./configure --enable-shared --prefix=/usr
make -j3
make install

# libvdpau-sunxi

cd /usr/local/src/
git clone -b deint https://github.com/zillevdr/libvdpau-sunxi/
cd libvdpau-sunxi
make -j3
make install

# softhddevice Makefile

CONFIG += -DUSE_BITMAP   	# VDPAU, use bitmap surface for OSD

override CXXFLAGS += $(_CFLAGS) $(DEFINES) $(INCLUDES) \
	-g -W -Wall -Wextra -Winit-self -Werror=overloaded-virtual -fsigned-char
override CFLAGS>  += $(_CFLAGS) $(DEFINES) $(INCLUDES) \
	-g -W -Wall -Wextra -Winit-self -Wdeclaration-after-statement -fsigned-char







