# Insprirations
 - https://www.linkedin.com/pulse/installing-opnsense-firewall-kvm-sergio-maeso-jim%C3%A9nez/
 - https://discuss.linuxcontainers.org/t/bridging-wifi-to-lan/18598
 - https://mike42.me/blog/2018-03-automating-lxc-container-creation-with-ansible
 - https://gist.github.com/maxivak/1e197ca600499ae2a0b60d8dfa207864
 - https://developers.redhat.com/blog/2018/10/22/introduction-to-linux-interfaces-for-virtual-networking#bridge
 - https://www.cloudnull.io/2019/04/running-services-in-network-name-spaces-with-systemd/
# Goal

## Physical interface

```
+--------------------------------------------------+
|                  Topton X4C-XL                   |
|  +--------+  +--------+  +--------+  +--------+  |
|  |        |  |        |  |        |  | (WAN)  |  |
|  | enp2s0 |  | enp3s0 |  | enp4s0 |  | enp5s0 |  |
|  | (LAN)  |  | (LAN)  |  | (LAN)  |  |        |  |
|  +--------+  +--------+  +--------+  +--------+  |
+--------------------------------------------------+
```
## Virtual networks
```
  The internet
       ||
   +--------+
   |        |
+--+ enp5s0 +-----------------+
|  |        | Public IP       |
|  +--------+                 |
|               NETNS WAN     |
|  +-------+                  |
|  |       |  10.10.10.2      |
+--+ veth0 +------------------+
   |       |
   +-------+
      | |
   +-------+
   |       |
+--+ veth1 +---------------------------------------+
|  |       |  10.10.10.1                           |
|  +-------+                                       |
|                    LANBR0 - 10.10.10.10/24       |
|  +--------+ +--------+ +--------+     +-------+  |
|  |        | |        | |        |     |       |  |
+--+ enp2s0 |-| enp3s0 |-| enp4s0 |-----+ veth2 +--+
   |        | |        | |        |     |       |
   +--------+ +--------+ +--------+     +-------+
                                           | |
                                        +-------+
                                        |       |
                                     +--+ veth3 +-------------------------------+
                                     |  |       |                               |
                                     |  +-------+     NETNS LX - 10.10.11.0/24  |
                                     |                                          |
                                     |                                          |
                                     +------------------------------------------+
```
# Init ansible

## Requirements
```script shell
sudo apt install python3-venv
```
## Init python venv
```script shell
python3 -m venv ~/.deblab-venv
source  ~/.deblab-venv/bin/activate
```
## Install ansible
```script shell
pip install --upgrade ansible
```



default via 192.168.1.1 dev enp5s0
192.168.1.0/24 dev enp5s0 proto kernel scope link src 192.168.1.21