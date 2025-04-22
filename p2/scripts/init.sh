#!/bin/bash

SERVER_IP="192.168.56.110"

echo ${SERVER_IP} app1.com app2.com app3.com >> /etc/hosts

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install curl -y

export K3S_KUBECONFIG_MODE="644"
export INSTALL_K3S_EXEC="--bind-address=${SERVER_IP} --node-external-ip=${SERVER_IP} --flannel-iface=eth1"

curl -sfL https://get.k3s.io | sh -

kubectl apply -f /vagrant/apps.yaml
kubectl apply -f /vagrant/ingress.yaml