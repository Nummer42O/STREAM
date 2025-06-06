#!/usr/bin/bash


wsDir="${1}"
cd "${wsDir}"/STREAM-DSM || exit

source /opt/ros/rolling/setup.bash || exit
source install/setup.bash || exit

set -x
colcon build \
  --symlink-install \
  --cmake-args \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
