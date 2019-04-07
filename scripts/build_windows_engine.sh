#!/bin/bash

. scripts/lib.sh

# Build engine
cd $TRAVIS_BUILD_DIR

# NOTE: to build with other version use --msvc_version during configuration
# NOTE: sometimes you may need to add WinSDK to %PATH%
./waf.bat configure -s "$TRAVIS_BUILD_DIR/SDL2_VC" -T "debug" --prefix=`pwd`
./waf.bat build
echo After build

cp $TRAVIS_BUILD_DIR/SDL2_VC/lib/x86/SDL2.dll . # Install SDL2
cp vgui-dev/lib/win32_vc6/vgui.dll .
./waf.bat install

7z a -t7z $TRAVIS_BUILD_DIR/xash3d-vc.7z -m0=lzma2 -mx=9 -mfb=64 -md=32m -ms=on *.dll *.exe *.pdb
