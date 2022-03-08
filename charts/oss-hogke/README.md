# oss applications integration to ingress
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
└── oss-od-web-rc
    ├── Chart.yaml
    ├── templates
    │   ├── _helpers.tpl
    │   ├── ingress.yaml
    │   └── NOTES.txt
    └── values.yaml

```
`oss-hogke` is the parent directory, under which multiple subdirectories are stored in parallel, and each directory corresponds to an applied ingress rule. If there are 30 applications on the project, 30 subdirectories need to be listed here.

## Maintenance
If you need to add an ingress rule applying `oss-im-edesign-rc`, copy `oss-im-edesign-rc` as a new directory named `oss-im-edesign-rc`, and update the following files in turn:
### 1.Chart.yaml
`name`: application name, here is `oss-im-edesign-rc`.
### 2.values.yaml
`service.port`: container port, here is `8080`
`ingress.host`: external domain host, here is `dev.lumos.hyperoptic.com`
`ingres.annotations`: ingress annotations, format is `- rewritePath: MappingPath(.*)$ WebRoot$1`. If there are multiple rules, configure them in sequence. Here is
```
- rewritePath: rewrite /oss/edesign(.*)$ /edesign$1
- rewritePath: rewrite /oss/bc/im_edesign/appInfo/status(.*)$ /opb/appInfo/status$1
- rewritePath: rewrite /oss/auth(.*)$ /auth$1
```
`ingress.path`: ingress path, format is `- externalPath: 匹配路径`. If there are multiple rules, configure them in sequence. Here is
```
- externalPath: /oss/edesign
- externalPath: /oss/bc/im_edesign/appInfo/status
- externalPath: /oss/auth
```

## Access Environment
### 1. List Release
```
helm ls -n hogke
```
### 2. Add Release
```
helm install oss-im-edesign-rc oss-hogke/oss-im-edesign-rc -n hogke
```
### 3. Upgrade Release
```
helm upgrade oss-im-edesign-rc oss-hogke/oss-im-edesign-rc -n hogke
```
### 4. Remove Release
```
helm uninstall oss-im-edesign-rc oss-hogke/oss-im-edesign-rc -n hogke
```
