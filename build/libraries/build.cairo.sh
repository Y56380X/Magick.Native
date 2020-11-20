#!/bin/bash
set -e

cd cairo

rm src/cairo-features.h

autoreconf -fiv
chmod +x ./configure
$CONFIGURE --disable-shared --enable-quartz=no --prefix=/usr/local CFLAGS="$FLAGS" $CROSS_COMPILE_FLAGS
$MAKE install
