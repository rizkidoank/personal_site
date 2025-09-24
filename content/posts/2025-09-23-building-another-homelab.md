---
title: "Building Poor-man Homelab to Learn AI and MLOps"
date: 2025-09-24T00:03:00+08:00
---

## Long Story..
Back then before COVID, I have some mining GPUs and servers. But, due to the ETH moving away from PoW to PoS, the profitability drastically reduced (minus in fact) and I decided to put down the servers. There are 4 servers with LGA1151 and all of them are DIY, there are also 8 GPUs:
- 1 x GTX 1080 Turbo
- 3 x P104-100
- 1 x GTX 1080 Ti
- 1 x RTX 3060
- 1 x RX 580
- 1 x RTX 2070 Super

Recently I interested to learn about MLOps and also AI infra. I picked all of them and clean it from the thick dust and bit rusty (it feels like opening new garage with some legendary muscle cars in it 😂) and decided to tests them along with the servers.

## Tests All the Hardware
After the cleaning, I tried to tests all of the servers and GPU. 

The good news
- all of the GPU are alive!
- The motherboards also works well.
- 1 ATX PSU works well (but seems like its not able to achieve its maximum capacity)

The bad news:
- 1 CPU is dead
- I only have mATX and ITX cases (and all my mobo is ATX). Earlier I created my own open case from LGS, but I don't want to use it since its not looks nice for my homelab 😂.
- The remaining ATX PSU are dead, 1 Flex PSU is alive but I don't think I'm gonna use it, its too loud.

## Rebuild the Server
Since I only have mATX cases, the motherboard needs to be replaced so I decided to rebuild one server for now. In Indonesia, its a bit hard to get a server motherboard, but then I found this [**Gigabyte MX31-CE0**](https://tk.tokopedia.com/ZSDQxdPca/). Its using relatively old **Intel C232** chipset, but I think its good enough considering the price and features. I use Intel **Xeon E3-1230 v6**, good enough with **4 cores and 8 threads**. For the RAM, I opted to use consumer line RAM with **3 x 16GB** and **1 x 8GB**. You might asks why not 4 x 16GB? Simply because I already 1 x 8GB and I think 56GB is a good start. For storage, I have to buy **PCIe x2 NVMe adapter** since this board unfortunately doesn't have NVMe, and then install it with **256GB NVMe** also **2TB of HDD in SATA**.

I almost forgot the main parts, **GPU**! For this server, I decided to use **P104-100**. Initially using the **RTX 3060** but the PSU can't keep up it seems, somehow the P104-100 works well though. This is a sub-optimal decision, since P104-100 **bandwidth is too low** compared to RTX and also has **limited VRAM**. But, I think its OK for now and my goal is to reuse all the GPU in near future.

Aside this server, I also have **Asrock Deskmini X300** which will be the temporary pair for the cluster. Its a decent build with **Ryzen 5 Pro 4650G**, **32GB** of RAM, **1 x 256GB NVMe** and additionally **2 x 480GB SATA SSD**. This server will be utilized as storage, and also for other **CPU intensive workloads**, not sure for the **APU** since it doesn't support **ROCm**. Done for now, lets move to architecture.

## Hypervisor / Virtualization Platform
I tried different options for the hypervisor and the decision is to go with Proxmox VE 9.0. How I decide this?
- Proxmox VE 9.0: easy to install, relatively easy to setup and maintain. Its also supports KVM and LXC, which is great.
- VSphere ESXi 8 + vCenter: very nice platform and it has Terraform provider. But, the vCenter using very high on resources. I also experiences instability in my deskmini, sometimes kernel panic on reboot.
- Microcloud: this also great. Install distro with snapd in it, then install the microcloud snap and initialize the cluster. While its supposed to be an easy to use hypervisor, I found that its involve lots of CLI interaction when it comes to make changes on the components such as LXD, MicroOVN, MicroCeph.
- Openstack, OpenNebula, CloudStack: all of mentioned are great, but there is no easy way to bootstrap which will bring my focus away. Possibly will create Openstack on top of the KVM with nesting virtualization.
- XCP-ng: nice Xen based platform, but I'm not really into it for now. The web interface is not as powerful like Proxmox or Vsphere.
- Libvirt: lightweight, but I need user interface that can be accessed anywhere and also I don't want to deal with much CLI if possible.

## Architecture
For the first iteration, unfortunately only 1 GPU server paired temporarily with my deskmini. Here is the overview architecture:
![GPU Homelab Architecture v0.1.0](/img/2025-09-23-homelab-diagram.png)

This fairly simple architecture. The ISP router is on different room with my room, so I need a wireless router to connect to it, then the homelab will using this router as the gateway. I planned to add some other nodes in near future, so I also add 8 ports 1Gbit unmanaged switch which connected to GL-INET B1300 router. The servers are connected through the switch. With both of the servers installed with Proxmox VE 9.0, then I create a cluster.

![Proxmox Node Summary](/img/2025-09-24-proxmox-node-summary.png)

![Proxmox Summary](/img/2025-09-24-proxmox-cluster-summary.png)

As you can see, now I have **20 CPUs**, **82GB of RAM**, and **3TB of storage** in total. Its a good start actually. The GPU server is `pve-hound` and the deskmini is `pve-wolf`. I also create `prd-nvrun-rck` which basically the GPU runner on top of Rocky Linux containers and as you can see, the GPU is recognized from the container. I will create a separate post to configure this. See the below image for the `nvidia-smi` result.

![Nvidia GPU Runner](/img/2025-09-24-nvrun.png)

I initially thinking to have vGPU but its not free and also needs server GPU like Tesla RTX which I don't have at this point. Possibly I'll add another P104-100s so that this server will have 2-3 GPU (but I think need to upgrade the PSU first 🥲)

## Closing Words
Its nice to see one of GPU back! It was also interesting time to tinkering on hardware and this homelab stuff again. There are some other next steps including adding back the remaining GPUs so I can create a "GPU cluster", another thing also test it for model training and now it means I can learn the MLOps and AI with this poor-man GPU server.

I thinking its gonna be fun to play with this in large scale, let me know if you need a DevOps with ML / AI interests, I would be interested to talk and work with you. 😄