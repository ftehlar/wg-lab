#!/bin/bash

# WireGuard configuration directory
WG_CONF_DIR="/etc/wireguard"

# Ensure Docker is installed
if ! command -v docker &> /dev/null; then
  echo "Docker is not installed. Please install Docker first."
  exit 1
fi

# Check if the WireGuard configuration directory exists
if [ ! -d "$WG_CONF_DIR" ]; then
  echo "WireGuard configuration directory ($WG_CONF_DIR) not found!"
  exit 1
fi

# Create 10 Docker containers using a pre-built WireGuard image
for i in {1..10}; do
  CONTAINER_NAME="wireguard-container-$i"

  echo "Creating container $CONTAINER_NAME..."

  docker run -d --name $CONTAINER_NAME \
    --privileged \
    --cap-add=NET_ADMIN \
    --cap-add=SYS_MODULE \
    --sysctl net.ipv4.ip_forward=1 \
    --sysctl net.ipv6.conf.all.forwarding=1 \
    -v "$WG_CONF_DIR:/config" \
    --restart unless-stopped \
    linuxserver/wireguard

  if [ $? -eq 0 ]; then
    echo "Container $CONTAINER_NAME is running."
  else
    echo "Failed to create $CONTAINER_NAME."
  fi
done
