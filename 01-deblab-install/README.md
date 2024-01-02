# Insprirations
Just enough preseed for ansible
 - https://www.debian.org/releases/trixie/example-preseed.txt
 - https://github.com/coreprocess/linux-unattended-installation/blob/master/ubuntu/20.04/custom/preseed.cfg
 - https://framagit.org/fiat-tux/hat-softwares/preseed-creator

# Init
```
sudo apt install wget genisoimage rsync cpio xorriso
```

# Build install iso
```
wget -c https://cdimage.debian.org/cdimage/weekly-builds/amd64/iso-cd/debian-testing-amd64-netinst.iso
sudo ./preseed-creator -i debian-testing-amd64-netinst.iso -p preseed.cfg -o deblab-testing-amd64-netinst.iso