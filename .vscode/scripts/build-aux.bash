#!/usr/bin/bash


wsDir="${1}"
cd "${wsDir}"/STREAM-DSM || exit

source /opt/ros/rolling/setup.bash || exit
if [[ -d install ]]; then
  source install/setup.bash || exit
fi

set -x
colcon build \
  --symlink-install \
  --cmake-args \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  --packages-select dbs ipc babeltrace_plugins tracer
