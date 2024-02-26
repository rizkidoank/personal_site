---
title: "Bootstrapping Argocd With Terraform"
date: 2024-02-27T01:11:46+08:00
---

## Overview
Kubernetes has lot of flexibility and features. But, in order to make use of it to the full potential, it requires us to install some essentials tools in it. One of the example of the most used tools in industry right now is ArgoCD. ArgoCD allows us to manage the applications inside the Kubernetes cluster. This post written to help you on how to bootstrapping the Kubernetes cluster.


## What is Bootstrapping?
- Bootstrapping is to make your system ready by ensuring it loads your essential components
- In Kubernetes, we have options to bootstrap the cluster with several examples:
  - Having ingress controller, prometheus operator, and telemetry collector
  - Having applications management / delivery tools installed like ArgoCD or FluxCD
- In this case we want to bootstrap ArgoCD to the cluster, so that for all the remaining components can be managed using Application or ApplicationSet in ArgoCD

## Why Bootstrapping?
- Bootstrapping will only contains the minimum essentials tools get installed
- This will make the cluster management less painful
- We can manage the essentials tools altogether with cluster provisioning definition
- We can separate the other essentials tools management into different layer (for ArgoCD, using Application or ApplicationSet)

## How to Bootstrapping Kubernetes Cluster?
- Terraform widely known tools to provisioning Kubernetes cluster
- It has Helm provider support
- Helm chart is versioned and more easier than dealing with plain manifests (especially if we have it already in [artifacthub](https://artifacthub.io), haha)
- We can leverage Terraform and Helm to bootstrap the cluster
- So we can manage the cluster provisioning (using whatever your cloud platform is), and manage the essentials components (in this case ArgoCD)

See below Terraform snippet to bootstrapping the ArgoCD with the cluster. The snippet assuming that the kubeconfig is there locally. So if you want to have it together with your cluster definition, you might need to adjust the kubernetes and helm provider in order to authenticate to the cluster.

```terraform
terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.12.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.25.2"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "infrastructure" {
  metadata {
    name = "infrastructure"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = "6.0.12"
  namespace  = kubernetes_namespace.infrastructure.metadata[0].name

  values = ["${file("argocd-values.yml")}"]
}

resource "helm_release" "nginx_ingress" {
  name       = "ingress-nginx"
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  version    = "4.9.1"
  namespace  = kubernetes_namespace.infrastructure.metadata[0].name

  set {
    name  = "controller.ingressClassResource.name"
    value = "nginx"
  }
}
```

### How it Works?
Assumptions:
- We would like the components installed to `infrastructure` namespace
- We would like to have ArgoCD with the Web UI
  - So we need ingress controller as part of the bootstrap components
- The given snippet is minimal PoC, so no security practice applied there
  - You might adjust the config as your security requirements (i.e: provision the ingress to internal LB, etc)

Below is the explanation for the above snippets.
1. We configure the providers for both `kubernetes` and `helm`
   ```terraform
    terraform {
        required_providers {
            helm = {
                source  = "hashicorp/helm"
                version = "2.12.1"
            }

            kubernetes = {
                source  = "hashicorp/kubernetes"
                version = "2.25.2"
            }
        }
    }

    provider "helm" {
        kubernetes {
            config_path = "~/.kube/config"
        }
    }

    provider "kubernetes" {
        config_path = "~/.kube/config"
    }
   ```
2. Creating the targeted namespace
    ```terraform
    resource "kubernetes_namespace" "infrastructure" {
        metadata {
            name = "infrastructure"
        }
    }
    ```
3. Deploy the ingress controller and ArgoCD
    ```terraform
    resource "helm_release" "argocd" {
        name       = "argocd"
        chart      = "argo-cd"
        repository = "https://argoproj.github.io/argo-helm"
        version    = "6.0.12"
        namespace  = kubernetes_namespace.infrastructure.metadata[0].name

        values = ["${file("argocd-values.yml")}"]
    }

    resource "helm_release" "nginx_ingress" {
        name       = "ingress-nginx"
        chart      = "ingress-nginx"
        repository = "https://kubernetes.github.io/ingress-nginx"
        version    = "4.9.1"
        namespace  = kubernetes_namespace.infrastructure.metadata[0].name

        set {
            name  = "controller.ingressClassResource.name"
            value = "nginx"
        }
    }
    ```
4. The helm applications will be installed in the cluster and your ArgoCD and ingress controller will be installed after some times.

As you can see in the above, there is `argocd-values.yml`, this is basically the parameters of the helm chart. See below example for references that I used for my local Kubernetes:
```yaml
controller:
  resources:
    limits:
      cpu: "100m"
      memory: "128Mi"
dex:
  resources:
    limits:
      cpu: "10m"
      memory: "32Mi"
redis:
  resources:
    limits:
      cpu: "10m"
      memory: "32Mi"
repoServer:
  resources:
    limits:
      cpu: "1000m"
      memory: "512Mi"
server:
  resources:
    limits:
      cpu: "100m"
      memory: "128Mi"
  ingress:
    enabled: true
    ingressClassName: nginx
    hostname: argocd.rizkidoank.local

configs:
  params:
    server.insecure: true
```

Given the values parameters above, after everything installed, the ArgoCD will be accessible with `argocd.rizkidoank.local`

## What to Do Next?
- We have the cluster bootstrapped with ArgoCD and NGINX ingress controller
- The cluster is now ready to be managed with ArgoCD
- You may continue with applying your essentials ApplicationSet or Application to the cluster
  - You may have base infra Application which includes observability stacks, secret management, certificate managers, service mesh, etc.
- After the essential applications installed, you can create your product / services application

I might write the guide to create or manage base infra applications or creating ArgoCD application for our own service in another posts. For more in depth about ArgoCD, you may refer to the docs [argo-cd.readthedos](https://argo-cd.readthedocs.io/en/stable/)