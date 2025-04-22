#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 [server|agent]"
  exit 1
fi

ROLE=$1
SERVER_IP="192.168.56.110"

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install curl -y


if [ "$ROLE" == "controller" ]; then

  export K3S_KUBECONFIG_MODE="644"
  export INSTALL_K3S_EXEC="--bind-address=${SERVER_IP} --node-external-ip=${SERVER_IP} --flannel-iface=eth1"

  curl -sfL https://get.k3s.io | sh -

  sudo cp /etc/rancher/k3s/k3s.yaml /vagrant/
  sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/token

elif [ "$ROLE" == "agent" ]; then
  export K3S_URL="https://${SERVER_IP}:6443"
  export K3S_TOKEN_FILE="//vagrant/token"
  export INSTALL_K3S_EXEC="--flannel-iface=eth1"

  curl -sfL https://get.k3s.io | sh -

else
  echo "Invalid role specified: $ROLE."
  exit 1
fi
