#!/usr/bin/bash


curl \
  -X POST \
  -H 'Content-Type: application/json' \
  -d '{"statements": [{"statement": "MATCH (n) DETACH DELETE n", "parameters": {}}]}' \
  "http://neo4j:123456789@neo4j:7474/db/neo4j/tx/commit" \
  || exit
echo

msgQueueId="$(ipcs -qp | grep -oE '^[0-9]+\s*ubuntu' | grep --color=never -oE '^[0-9]+')"
if [[ -n ${msgQueueId} ]]; then
  echo "Removing msg queue with id: ${msgQueueId}"
  ipcrm -q "${msgQueueId}" || exit
else
  echo "No message queue found."
fi
