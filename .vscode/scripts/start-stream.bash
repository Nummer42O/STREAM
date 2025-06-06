#!/usr/bin/bash

function _waitFor {
  local waitS="${1}"
  for x in $(seq ${waitS} 1); do
    printf "\rWaiting, %ds remaining." $x
    sleep 1
  done
  printf "\nDone waiting.\n"
}

wsDir="${1}"

# reset lttng
# TODO: "|| exit" ?
lttng destroy -a
lttng-sessiond --daemonize
lttng-relayd -d
rm -rf /tmp/continuous_traces
rm -rf /tmp/structural_traces
_waitFor 1

terminator --config "${wsDir}"/.vscode/scripts/terminator-config
