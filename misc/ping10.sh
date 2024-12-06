#!/bin/bash

TARGET_ADDRESS="10.0.0.1"
CONTAINER_PREFIX="wireguard-container"
NUM_CONTAINERS=10

for i in $(seq 1 $NUM_CONTAINERS); do
  CONTAINER_NAME="${CONTAINER_PREFIX}-${i}"

  echo "Pinging $TARGET_ADDRESS from $CONTAINER_NAME..."
  docker exec $CONTAINER_NAME ping $TARGET_ADDRESS &
done

wait
echo "All pings completed."
