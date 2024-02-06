# Insprirations
 - https://www.debian.org/releases/trixie/example-preseed.txt
 - https://preseed.debian.net/debian-preseed/trixie/amd64-main-full.txt
 - https://github.com/coreprocess/linux-unattended-installation/blob/master/ubuntu/20.04/custom/preseed.cfg
 - https://framagit.org/fiat-tux/hat-softwares/preseed-creator
 - https://notabug.org/LiohMoeller/installbox/src/master/preseed.cfg

# Just enough preseed for ansible
#### no root, lvm

# Init
```script shell
sudo apt install wget gpg genisoimage rsync cpio xorriso isolinux ovmf
```

# Build install iso
## Debian testing ( default if no -i option passed )
```script shell
sudo ./preseed-creator -p preseed.cfg -k ~/.ssh/id_ed25519.pub -g ./grub.cfg -i debian-testing-amd64-netinst.iso -o deblab-testing-amd64-netinst.iso -t 1 -x -v
```
## Debian stable
```script shell
sudo ./preseed-creator -p preseed.cfg -k ~/.ssh/id_ed25519.pub -g ./grub.cfg -i debian-12.4.0-amd64-netinst.iso -o deblab-12.4.0-amd64-netinst.iso -t 1 -x -v
```

# Testing with qemu
```script shell
qemu-img create -f qcow2 deblab.img 24G

qemu-system-x86_64 -M q35 -cdrom debian-testing-amd64-netinst.iso \
-drive file=deblab.img,if=none,id=nvm-device \
-device nvme,serial=deadbeef,drive=nvm-device \
-device pxb-pcie,id=pcie.2 -device pcie-pci-bridge,bus=pcie.2,addr=0x0 \
-device pxb-pcie,id=pcie.3 -device pcie-pci-bridge,bus=pcie.3,addr=0x0 \
-device pxb-pcie,id=pcie.4 -device pcie-pci-bridge,bus=pcie.4,addr=0x0 \
-device pxb-pcie,id=pcie.5 -device pcie-pci-bridge,bus=pcie.5,addr=0x0 \
-bios /usr/share/ovmf/OVMF.fd \
-m 4096 -smp 4 -boot d

qemu-system-x86_64 -M q35 -cdrom deblab-testing-amd64-netinst.iso \
-device pxb-pcie,id=pcie.2,bus_nr=2 \
-device pxb-pcie,id=pcie.3,bus_nr=3 \
-device pxb-pcie,id=pcie.4,bus_nr=4 \
-device pxb-pcie,id=pcie.5,bus_nr=5 \
-device pcie-pci-bridge,id=pcie_pci_bridge2,bus=pcie.2,addr=0x0 \
-device pcie-pci-bridge,id=pcie_pci_bridge3,bus=pcie.3,addr=0x0 \
-device pcie-pci-bridge,id=pcie_pci_bridge4,bus=pcie.4,addr=0x0 \
-device pcie-pci-bridge,id=pcie_pci_bridge5,bus=pcie.5,addr=0x0 \
-bios /usr/share/ovmf/OVMF.fd \
-drive file=deblab.img,if=none,id=nvm-device \
-device nvme,serial=deadbeef,drive=nvm-device \
-m 4096 -smp 4 -boot d

qemu-system-x86_64 \
-netdev user,id=n1 -device virtio-net-pci,netdev=n1,bus=pci.0 \
-netdev user,id=n2 -device virtio-net-pci,netdev=n2,bus=pci.0 \
-netdev user,id=n3 -device virtio-net-pci,netdev=n3,bus=pci.0 \
-netdev user,id=n4 -device virtio-net-pci,netdev=n4,bus=pci.0 \
-bios /usr/share/ovmf/OVMF.fd \
-drive file=deblab.img,if=none,id=nvm-device \
-device nvme,serial=deadbeef,drive=nvm-device \
-m 4096 -smp 4
```