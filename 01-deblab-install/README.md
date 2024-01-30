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

qemu-system-x86_64 -cdrom deblab-testing-amd64-netinst.iso -net nic -net user -bios /usr/share/ovmf/OVMF.fd -drive file=deblab.img,if=none,id=nvm-device -device nvme,serial=deadbeef,drive=nvm-device -m 4096 -smp 4 -boot d

qemu-system-x86_64 -net nic -net user -bios /usr/share/ovmf/OVMF.fd -drive file=deblab.img,if=none,id=nvm-device -device nvme,serial=deadbeef,drive=nvm-device -m 4096 -smp 4
```