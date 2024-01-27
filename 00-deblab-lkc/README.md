WIP

# Insprirations
 - https://debian-handbook.info/browse/pl-PL/stable/sect.kernel-compilation.html
 - https://kernel-team.pages.debian.net/kernel-handbook/ch-common-tasks.html#s-common-official
 - https://wiki.debian.org/BuildADebianKernelPackage

# Init
```script shell
sudo apt-get install build-essential linux-source bc kmod cpio flex libncurses5-dev libelf-dev libssl-dev dwarves bison
```

# Build kernel package
```script shell
tar xavf /usr/src/linux-source-X.YY.tar.xz
cd linux-source-X.YY
cp ../config-X.YY ./.config
make ARCH=x86 menuconfig
export DEB_BUILD_PROFILES='pkg.linux.nokerneldbg pkg.linux.nokerneldbginfo'
nice make -j6 bindeb-pkg LOCALVERSION=-x4xl KDEB_PKGVERSION=$(make kernelversion)-1
```