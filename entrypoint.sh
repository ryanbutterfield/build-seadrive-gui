#!/bin/bash

set -e

export VERSION=2.0.28
export FUSE_VERSION=2.0.28
export PREFIX=/usr
export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
export PATH="$PREFIX/bin:$PATH"

cd /data

rm -rf *

wget --content-disposition -nc https://github.com/haiwen/libsearpc/archive/v3.2-latest.tar.gz
wget --content-disposition -nc https://github.com/haiwen/seadrive-fuse/archive/v${FUSE_VERSION}.tar.gz
wget --content-disposition -nc https://github.com/haiwen/seadrive-gui/archive/v${VERSION}.tar.gz

tar xfv libsearpc-3.2-latest.tar.gz
tar xfv seadrive-fuse-${FUSE_VERSION}.tar.gz
tar xfv seadrive-gui-${VERSION}.tar.gz

cp libsearpc-3.2-latest.tar.gz libsearpc1_3.2.0.orig.tar.gz
cp seadrive-fuse-${FUSE_VERSION}.tar.gz seadrive-daemon_${FUSE_VERSION}.orig.tar.gz
cp seadrive-gui-${VERSION}.tar.gz seadrive-gui_${VERSION}.orig.tar.gz

cd /data/libsearpc-3.2-latest
cp /libsearcpc-fix-pkgconfig-paths.patch debian/patches/fix-pkgconfig-paths.patch
dpkg-buildpackage -us -uc

cd /data
dpkg -i *.deb

cd /data/seadrive-fuse-${FUSE_VERSION}
dpkg-buildpackage -us -uc

cd /data
dpkg -i *.deb

cd /data/seadrive-gui-${VERSION}
dpkg-buildpackage -us -uc

cd /data
rm *dbg*.deb
rm *dev*.deb
mv *.deb /tmp
rm -rf *
mv /tmp/*.deb .

echo 'Done!'
