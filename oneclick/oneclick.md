# One Click Deploy ZCM on GKE
## Background
Cleandesk deployment is necessary after the review for ensuring the repeatability of the deployment.
## Prerequisites
The installation assumes the following:
- Virtual machine (VM) prepared to store deploy packages.
- Mysql instance is avaiable to connect.
- Pre-existing Kubernetes (K8S) cluster managed by GKE.
- Kubeconfig file available with adequate permissions on the K8S cluster to:
  Manage namespaces
- Artifact registry (AR) prepared to store docker images.
- Helm 3 is available and configured to use the kubeconfig.
- Firewall rules configuration for ZCM.
## Prerequisites Details
### VM
- OS: CentOS 7.8
- CPU: 2C
- Memory: 4GB
- Disk: 100GB free space for data volume.
### Database
compatible MySQL 5.7.x, provide database connection info ip/port/username/password with dba privileges.
### Service Accounts
Create Service Account for GKE, permissions with role `Editor`, download key files.
Create Service Account for AR, permissions with role `Editor`, download key files.
### Kubernetes
Create one node pool named `zcm-pool` with `n2-standard-8` machine type.
From VM can access GKE.
### Registry
Create default registry `zcm9` for deploying ZCM.
From VM can access AR.
### Firewall
| name                                    | description                                                  | type    | ip range                                           | protocol & port                                              |
| --------------------------------------- | ------------------------------------------------------------ | ------- | -------------------------------------------------- | ------------------------------------------------------------ |
| zcm-ingress-ibase                       | zcm-ingress-ibase                                            | Ingress | host network segment                               | tcp:52000 tcp:52306 tcp:52379 tcp:52876 tcp:52780 tcp:52860 tcp:52861 tcp:52835 tcp:52888 tcp:52800 tcp:52981 |
| zcm-ingress-itracing                    | zcm-ingress-itracing                                         | Ingress | host network segment                               | tcp:52980 tcp:52920-52949 tcp:52900-52909 tcp:52966 tcp:52990 tcp:52991 tcp:52992 tcp:52950-52959 tcp:52960-52965 tcp:52910-52919 tcp:52994 tcp:52984 tcp:52181 tcp:52983 tcp:52960-52963 tcp:52950-52957 tcp:9994-9996 tcp:52970-52972 tcp:52993 tcp:52999 |
| zcm-ingress-iplatform                   | zcm-ingress-iplatform                                        | Ingress | host network segment                               | tcp:179 tcp:2379 tcp:2378 tcp:6443 tcp:52080 tcp:52870 tcp:2375 tcp:2376 tcp:52180 tcp:52280 tcp:52380 tcp:52680 tcp:52090 tcp:52878 tcp:52805 tcp:52091 |
| zcm-ingress-imornitor                   | zcm-ingress-imornitor                                        | Ingress | host network segment                               | tcp:52022 tcp:52503 tcp:52001 tcp:52500 tcp:52616 tcp:8593 tcp:8594 tcp:9100 tcp:8586 |
| zcm-ingress-icicd                       | zcm-ingress-icicd                                            | Ingress | host network segment                               | tcp:52480 tcp:52899 tcp:52487 tcp:52482 tcp:52493 tcp:52490 tcp:52485 |
| zcm-ingress-k8s                         | zcm-ingress-k8s                                              | Ingress | host network segment                               | tcp:52090 tcp:25280 tcp:52280 tcp:179 tcp:2375 tcp:52870 tcp:8780 tcp:52878 tcp:52678 tcp:25878 tcp:22 tcp:10250 tcp:10255 |
| zcm-ingress-gateway                     | zcm-ingress-gateway                                          | Ingress | host network segment<br/>container network segment | tcp:52878 tcp:52678 tcp:25878                                |
| k8s-fw-a440712cf1fa642a4919dbef5b232f10 | {"kubernetes.io/service-name":"zcm9/ingress-nginx-controller-b6klc-2r8v5", "kubernetes.io/service-ip":"172.24.19.225"} | Ingress | 0.0.0.0/0                                          | tcp:52000 tcp:25000                                          |
| gke-ingress                             | gke-ingress                                                  | Ingress | host network segment<br/>container network segment | tcp:8132 tcp:10250 tcp:443 tcp:22 tcp:6379 tcp:53 tcp:80 tcp:30930 tcp:8080 udp:53 |
## Procedures
### Install on VM
- docker
- mysql-client
- kubectl
- helm
### Load & Push images to AR
Load & Push images to AR.
### Initialize database scripts
Import database scripts to database.
### Initialize GKE
Create namespace/configmap/secret, etc.
### Deploy ZCM
Deploy ZCM module functions by helm. Including
#### zcm-system-base
- zcm-redis
- zcm-timezone
#### zcm-system-env
- zcm-env-base
- zcm-env-cicd
- zcm-env-cluster
- zcm-env-local
- zcm-env-nms
#### zcm-ibase
- zcm-ansible
- zcm-cmdb
- zcm-dingding
- zcm-midware-yum
- zcm-portal
- zcm-zcamp
- zcm-zcamp-rest-server
#### zcm-imonitor
- nms-activemq
- zcm-dialing
- nms-grafana
- nms-kapacitor
- nms-metrics
- nms-monitor
#### zcm-iplatform
- zcm-application
- zcm-image
- zcm-resource
- zcm-service
- zcm-ssc
- zcm-tool
