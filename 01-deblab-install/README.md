# Insprirations
Just enough preseed for ansible
 - https://www.debian.org/releases/trixie/example-preseed.txt
 - https://preseed.debian.net/debian-preseed/trixie/amd64-main-full.txt
 - https://github.com/coreprocess/linux-unattended-installation/blob/master/ubuntu/20.04/custom/preseed.cfg
 - https://framagit.org/fiat-tux/hat-softwares/preseed-creator
 - https://notabug.org/LiohMoeller/installbox/src/master/preseed.cfg

no root, lvm

# Init
```
sudo apt install wget gpg genisoimage rsync cpio xorriso isolinux
```

# Build install iso
## Debian stable
```
sudo ./preseed-creator -p preseed.cfg -k ~/.ssh/id_ed25519.pub -i debian-testing-amd64-netinst.iso -o deblab-testing-amd64-netinst.iso -x -v
```
## Debian testing
```
sudo ./preseed-creator -p preseed.cfg -k ~/.ssh/id_ed25519.pub -i debian-12.4.0-amd64-netinst.iso -o deblab-12.4.0-amd64-netinst.iso -x -v
```