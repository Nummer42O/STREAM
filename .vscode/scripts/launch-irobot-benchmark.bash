#!/usr/bin/bash


wsDir="${1}"
cd "${wsDir}"/evaluation || exit

source /opt/ros/rolling/setup.bash || exit
source install/setup.bash || exit

ros2 run irobot_benchmark irobot_benchmark \
  --time 3600 \
  --results-dir "results/run-$(date +'%F-%H-%M')/" \
  --topology "src/ros2-performance/irobot_benchmark/topology/mont_blanc.json"
