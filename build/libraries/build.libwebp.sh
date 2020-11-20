#!/bin/bash
set -e

cd webp
autoreconf -fiv
chmod +x ./configure
$CONFIGURE ${WEBP_OPTIONS} --disable-shared CFLAGS="${FLAGS}" $CROSS_COMPILE_FLAGS
$MAKE install
