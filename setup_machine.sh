#!/bin/bash

# Install Vagrant
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install vagrant -y

# Install VBox
sudo apt install -y wget gnupg2 apt-transport-https ca-certificates dkms build-essential linux-headers-$(uname -r)
echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian bookworm contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/oracle_vbox.gpg
sudo apt update
sudo apt install virtualbox-7.1 -y

# Install Kubectl
apt-get install curl -y
curl -LO https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Install Docker
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Install K3D
wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Install ArgoCD CLI
curl -sSL -o argocd-linux-$(dpkg --print-architecture) https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-$(dpkg --print-architecture)
sudo install -m 555 argocd-linux-$(dpkg --print-architecture) /usr/local/bin/argocd
rm argocd-linux-$(dpkg --print-architecture)

# Add hosts for p2
echo 192.168.56.110 app1.com app2.com app3.com >> /etc/hosts

# Giving permissions for scripts
chmod +x ./p3/scripts/init.sh
