# GKE integration                      --version 1.3
## Prerequisites

The installation assumes the following:

- There is a pre-existing Kubernetes (K8s) cluster with an ingress controller configured
- The cluster is managed by GKE
- There is a kubeconfig file available with adequate permissions on the K8s cluster to:
  Manage namespaces
- Helm 3 is available and configured to use the kubeconfig.

## Tree Structure

```
oss-hogke
└── gke-lumos
    ├── Chart.yaml
    ├── templates
    │   ├── _helpers.tpl
    │   ├── ingress.yaml
    │   └── NOTES.txt
    └── values.yaml
```
`oss-hogke` is the parent directory. There is a chart named `gke-lumos` is used for managing ingress rules.

## Maintenance
If you need to add an ingress rule applying `demo2`, update the following files in turn:
### 1.values.yaml
Copy the following part as another parameter.
#### Before Updating:
```
ingress:
  enabled: true
  host: oss-gke.lumos.hyperoptic.com
  apps:
  - name: oss-od-web-rc
    port: 8080
    path:
      - externalPath: /oss/bc/od_web/appInfo/status
      - externalPath: /oss/static/oss_core/od
      - externalPath: /oss/oss_core/od
    pathType: Prefix
```
#### After Updating:
```
ingress:
  enabled: true
  host: oss-gke.lumos.hyperoptic.com
  apps:
  - name: oss-od-web-rc
    port: 8080
    path:
      - externalPath: /oss/bc/od_web/appInfo/status
      - externalPath: /oss/static/oss_core/od
      - externalPath: /oss/oss_core/od
    pathType: Prefix
  - name: demo2
    port: 8080
    path:
      - externalPath: /aaa/bbb/ccc
      - externalPath: /ddd/eee/fff
      - externalPath: /ggg/hhh/iii
    pathType: Prefix
```
Description for each parameter:
`ingress.enabled`: default value: `true`.
`ingress.host`: external domain host, here is `oss-gke.lumos.hyperoptic.com`.
`ingress.apps`: Display the forwarding rules of each micro service in the form of array.
`ingress.apps.path`: ingress path, format is `- externalPath: matchPath`. If there are multiple rules, configure them in sequence. Here is

```
- externalPath: /oss/edesign
- externalPath: /oss/bc/im_edesign/appInfo/status
- externalPath: /oss/auth
```
`ingress.pathType`: path match type, apply `Prefix` as default value.

## Access Environment
### 1. List Release
```
helm ls -n hogke
```
### 2. Add Release
```
helm install gke-lumos oss-hogke/gke-lumos -n hogke
```
### 3. Upgrade Release
```
helm upgrade gke-lumos oss-hogke/gke-lumos -n hogke
```
### 4. Remove Release
```
helm uninstall gke-lumos -n hogke
```
