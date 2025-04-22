Running on a debian debian-12.10.0-amd64-netinst.iso in VM.

Make sure it is big enough (20 GO, 4 CPUs, 8195 memory)

Once the VM is set up, install Vagrant.

```
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install vagrant
```

install virtualbox so vagrant can use it to launch the VMs:

```
sudo apt install -y wget gnupg2 apt-transport-https ca-certificates dkms build-essential linux-headers-$(uname -r)

echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian bookworm contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/oracle_vbox.gpg

sudo apt update && sudo apt install virtualbox-7.0
```

Activate nested virtualization (on your host pc):
```
VBoxManage modifyvm {VM_NAME} --nested-hw-virt on
```