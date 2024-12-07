#!/bin/bash

mkdir -p build >/dev/null 2>&1
cd build

cmake -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE="../../misc/cmake/toolchain-arm-none-eabi-rpi0.cmake" ..

cmake --build . --parallel
#make
#make VERBOSE=1
