---
title: "Ressurection of My Homelab"
date: 2024-09-20T00:00:00+07:00
tags:
- english
- kubernetes
- homelab
---

1.5 years living in Singapore makes me put down my homelab. Despite I already made the environment accessible as possible, apparently its still has lot of issues due to Indonesia ISP unstability and also electricity issues. Since now I currently in Indonesia, I was decided to wake them up again!

## The Born of the Undead
I put my homelab in my working room, and since my house was empty and no one take care of it, then yaaa! Its fully covered by dusts. Unfortunately, several devices completely dead. I tried to turn on everything, zonk! I need to start from scratch again. Since I don't want to spend too much time building it at once, I started to pick up one of the machine that I often used for hypervisor. My DeskMini X300 is still solid AsRock! I was using plain LibVirt in the past and manage everyting using [terraform-libvirt](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs) which allows me to manage everything through pipeline. But, this time I try to do differently.

I decided to reinstall the server with Linux with VMWare Workstation, so that I can use it as my second workstation while still able to serve some VMs to my network. The VMs inside was Vault, some of old [vulnhub](https://www.vulnhub.com/) instances, kubernetes cluster, and nomad cluster. For now, I just thinking to run kubernetes cluster.

## Run Kubernetes in DinD
When we deal with hypervisor like VMWare, its better if we built the template first before we bootstrap the services / cluster. So I was planned to do the same by building 2 template images:
- almalinux9 base image
- k8s base image
Then after that spin 3 instances for 1 control plane and 2 worker. While everything is running, I rethink again how to simplify this, so that I don't need to maintain the base image time to time. So then there are 3 options that I possibly take:
- RKE2, the successor of RKE1 and combined with K3s. Apparently the installation is different from RKE1. In RKE1 we need to provide cluster config and we can bootstrap it remotely by running the rke binary. For RKE2, looks like the approach is using server and agent daemon, which mean I have to build config management playbook to manage this.
- K3s, I really like k3s since its very lightweight. Was thinking to use it but I hold it back and thinking maybe better to put k3s in my rpis instead as "edge cluster"
- Kind, this is basically kubernetes in docker. So its wrapping all the complexity of node management and bootstrapping. The nice thing is that its support multi-node! We can provide the config using yaml.

Between those three, I decided to pick kind for the cluster inside the X300. The consideration are:
- Lower maintenance overhead, I still able to have multi-node, but no need to maintain any template
- Lower performance overhead, VMWare no longer used now, everything running inside the docker engine on the host. Since its containers, so don't get "penalty" due to hardware emulation
- Still compatible with specific components like MetalLB, Calico CNI which I was using back in the day.
- I can focus on learn the kubernetes application layer instead of the ops
- While the `host` network is not supported, its still has [port mapping](https://kind.sigs.k8s.io/docs/user/configuration/#extra-port-mappings). Good enough for my cases. Since I also leverage [Cloudflared](https://github.com/cloudflare/cloudflared) to tunnel and expose the service to public (Thanks Cloudflare!)

Here is my config for kind:
```
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: rdlab
networking:
  disableDefaultCNI: true
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
- role: worker
- role: worker
- role: worker
```
And here is some explanation for the configs:
- So here I use `disableDefaultCNI: true` so it will not install `kindnets`, I'll install `calico` CNI on my own instead.
- In `control-plane`, I added the kubelet labels `ingress-ready=true` so that we can later install the ingress controller and it will installed to this node specifically.
- I also add port mapping for 80 and 443 so I can access the service locally later.
- I'll have 3 workers

Everything is set! The next thing we need to do is apply this:
```
# I use homebrew linux, so I'll install kind from brew
brew install kind
# create kind cluster using the config
kind create cluster --config config.yaml
```

`kind` will build the node images and then spin up the containers and bootstrap the kubernetes automatically for me. When the bootstrap is complete, it will give a new kubernetes context for this particular cluster. Since I currently only has this new context, thus running `kubectl` will automatically use this context:

```
$ kubectl cluster-info
Kubernetes control plane is running at https://127.0.0.1:38463
CoreDNS is running at https://127.0.0.1:38463/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.

$ kubectl get nodes        
NAME                       STATUS   ROLES           AGE     VERSION
rdlab-kind-control-plane   Ready    control-plane   3d15h   v1.31.0
rdlab-kind-worker          Ready    <none>          3d15h   v1.31.0
rdlab-kind-worker2         Ready    <none>          3d15h   v1.31.0
rdlab-kind-worker3         Ready    <none>          3d15h   v1.31.0
```

The cluster is ready to use! (but not really, we need to bootstrap the CNI and other stuff first.)

## Next
So one of the machine already back up. The next step probably I'll bootstrap all the basic components so that I can run some services on top of the cluster. Thanks for reading!
