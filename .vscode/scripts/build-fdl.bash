#!/usr/bin/bash


wsDir="${1}"
cd "${wsDir}"/STREAM-FDL || exit

if [[ -n ${ROS_VERSION} ]]; then
  >&2 echo "ERROR: Can not build when ROS2 is sourced."
  exit 1
fi

set -ex
set -o pipefail
date +'[%x %X]' > build/configure.log || exit
date +'[%x %X]' > build/build.log || exit
cmake \
  -S . \
  -B build/ \
  -DCMAKE_BUILD_TYPE=Debug \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  -DFDL_LOG_LEVEL=0 \
  -DFDL_LOG_TIMESTAMP=ON \
  -DFDL_LOG_MINIMAL=ON \
  2>&1 | tee build/configure.log
cmake --build build/ \
  2>&1  | tee build/build.log
