# zcm4ho
Necessary materials files for HO projects.

## What is this?
This repo will install and configure ZSmart Cloud Manager(ZCM) on Google Kubernetes Engine(GKE).

## Prerequisites

The installation assumes the following:

- There is a pre-existing Kubernetes (K8s) cluster with an ingress controller configured
- The cluster is managed by GKE
- There is a kubeconfig file available with adequate permissions on the K8s cluster to:
Manage namespaces
- Helm 3 is available and configured to use the kubeconfig.
- Mysql client is avaiable to connect database mantained on GKE.

## Catalog Description

### charts
ZCM helm charts, by helm we can manage ZCM services. Please refer `./charts/README.md`.
### zcm-nginx-ingress-controller
The nginx-ingress-controller module. Please refer `./zcm-nginx-ingress-controller/README.md`.
### ingress-nginx-loadbalancer.yaml
Loadbalancer type service of ZCM to expose zcm-nginx-ingress-controller.
### inoc-gateway-loadbalancer.yaml
Loadbalancer type service of inoc business services to expose inoc-gateway.
### values.yaml
Values when managing ZCM services. Please refer `./charts/README.md`.
