Running on a debian debian-12.10.0-amd64-netinst.iso in VM.

Make sure it is big enough (20 GO, 4 CPUs, 8195 memory)

Activate nested virtualization (on your host pc):

```
VBoxManage modifyvm {VM_NAME} --nested-hw-virt on
```

Once the VM created launch

```
./setup_machine.sh
```

It will install all dependencies needed for the project
