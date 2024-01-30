# Insprirations
 - https://www.linkedin.com/pulse/installing-opnsense-firewall-kvm-sergio-maeso-jim%C3%A9nez/
 - https://discuss.linuxcontainers.org/t/bridging-wifi-to-lan/18598
 - https://mike42.me/blog/2018-03-automating-lxc-container-creation-with-ansible
 - https://gist.github.com/maxivak/1e197ca600499ae2a0b60d8dfa207864

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
+--+ enp5s0 +----------------------+
|  |        |                      |
|  +--------+   WANBR              |
|                       +-------+  |
+-----------------------+       +--|
                        | veth0 | (NAT)
+-----------------------+       +--+
|                       +-------+  |
|   LX Router / Firewall ( VM )    |
|  +-------+                       |
+--+       +-----------------------+
   | veth1 | ( 10.10.10.1 )
+--+       +---------------------------------------+
|  +-------+                LANBR - 10.10.10.0/24  |
|                                                  |
|  +--------+ +--------+ +--------+                |
|  |        | |        | |        |     +-------+  |
+--+ enp2s0 |-| enp3s0 |-| enp4s0 |-----+       +--+
   |        | |        | |        |     | lxbr0 |
   +--------+ +--------+ +--------+  +--+       +---------------------------------------+
                                     |  +-------+               LX LAN - 10.10.11.0/24  |
                                     |                                                  |
                                     |                                                  |
                                     +--------------------------------------------------+
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