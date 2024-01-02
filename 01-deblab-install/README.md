# Insprirations
Just enough preseed for ansible
 - https://www.debian.org/releases/trixie/example-preseed.txt
 - https://github.com/coreprocess/linux-unattended-installation/blob/master/ubuntu/20.04/custom/preseed.cfg
 - https://framagit.org/fiat-tux/hat-softwares/preseed-creator

# Init
```
sudo apt install wget gpg genisoimage rsync cpio xorriso
```

# Build install iso
```
sudo ./preseed-creator -p preseed.cfg -k ~/.ssh/id_ed25519.pub -o deblab-testing-amd64-netinst.iso
```