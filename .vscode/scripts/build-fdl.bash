#!/usr/bin/bash

wsDir="${1}"
cd "${wsDir}"/STREAM-FDL || exit

if [[ -n ${ROS_VERSION} ]]; then
  >&2 echo "ERROR: Can not build when ROS2 is sourced."
  exit 1
fi

set -x
cmake \
  -S . \
  -B build/ \
  -DCMAKE_BUILD_TYPE=Debug \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  -DFDL_LOG_LEVEL=0 \
  -DFDL_LOG_TIMESTAMP=ON
cmake --build build/
