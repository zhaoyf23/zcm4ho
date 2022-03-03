# helm-chart-package

Project for aik install zcm helm chart. Publishing to external projects.

以下操作均在`/zcm/charts`目录下完成
## 安装
### zcm-system-env（必选）
包含`zcm-env-base、zcm-env-local、zcm-env-cluster、zcm-env-nms、zcm-env-cicd`
```
helm install zcm-env-base zcm-system-env/zcm-env-base -n zcm9 -f values.yaml
helm install zcm-env-local zcm-system-env/zcm-env-local -n zcm9 -f values.yaml
helm install zcm-env-cluster zcm-system-env/zcm-env-cluster -n zcm9 -f values.yaml
helm install zcm-env-nms zcm-system-env/zcm-env-nms -n zcm9 -f values.yaml
helm install zcm-env-cicd zcm-system-env/zcm-env-cicd -n zcm9 -f values.yaml
```
### zcm-system-base（必选）
包含`mysql、redis、timezone`
```
helm install zcm-system-base zcm-system-base -n zcm9 -f values.yaml
```
### zcm-ibase（必选）
包含`zcm-ansible、zcm-cmdb、zcm-dingding、zcm-midware-yum、zcm-portal、zcm-zcamp、zcm-zcamp-rest-server`
```
helm install zcm-ansible zcm-ibase/zcm-ansible -n zcm9 -f values.yaml
helm install zcm-cmdb zcm-ibase/zcm-cmdb -n zcm9 -f values.yaml
helm install zcm-dingding zcm-ibase/zcm-dingding -n zcm9 -f values.yaml
helm install zcm-midware-yum zcm-ibase/zcm-midware-yum -n zcm9 -f values.yaml
helm install zcm-portal zcm-ibase/zcm-portal -n zcm9 -f values.yaml
helm install zcm-zcamp zcm-ibase/zcm-zcamp -n zcm9 -f values.yaml
helm install zcm-zcamp-rest-server zcm-ibase/zcm-zcamp-rest-server -n zcm9 -f values.yaml
```
### zcm-iplatform（可选）
包含`zcm-application、zcm-baas、zcm-image、zcm-resource、zcm-service、zcm-ssc、zcm-tool`
```
helm install zcm-application zcm-iplatform/zcm-application -n zcm9 -f values.yaml
helm install zcm-baas zcm-iplatform/zcm-baas -n zcm9 -f values.yaml
helm install zcm-image zcm-iplatform/zcm-image -n zcm9 -f values.yaml
helm install zcm-resource zcm-iplatform/zcm-resource -n zcm9 -f values.yaml
helm install zcm-service zcm-iplatform/zcm-service -n zcm9 -f values.yaml
helm install zcm-ssc zcm-iplatform/zcm-ssc -n zcm9 -f values.yaml
helm install zcm-tool zcm-iplatform/zcm-tool -n zcm9 -f values.yaml
```
### zcm-imonitor（可选）
包含`nms-activemq、nms-grafana、nms-influxdb、nms-kapacitor、nms-metrics、nms-monitor、zcm-dialing`
```
helm install nms-activemq zcm-imonitor/nms-activemq -n zcm9 -f values.yaml
helm install nms-grafana zcm-imonitor/nms-grafana -n zcm9 -f values.yaml
helm install nms-influxdb zcm-imonitor/nms-influxdb -n zcm9 -f values.yaml
helm install nms-kapacitor zcm-imonitor/nms-kapacitor -n zcm9 -f values.yaml
helm install nms-metrics zcm-imonitor/nms-metrics -n zcm9 -f values.yaml
helm install nms-monitor zcm-imonitor/nms-monitor -n zcm9 -f values.yaml
helm install zcm-dialing zcm-imonitor/zcm-dialing -n zcm9 -f values.yaml
```
### zcm-imanager（可选）
包含`zcm-zcachemanager、zcm-zdaasmanager、zcm-zmqmanager`
```
helm install zcm-zcachemanager zcm-imanager/zcm-zcachemanager -n zcm9 -f values.yaml
helm install zcm-zdaasmanager zcm-imanager/zcm-zdaasmanager -n zcm9 -f values.yaml
helm install zcm-zmqmanager zcm-imanager/zcm-zmqmanager -n zcm9 -f values.yaml
```

### zcm-icicd（可选）
包含`zcm-cicd、zcm-cicd-task、zcm-cloudtest、zcm-devspace、zcm-gitea、zcm-ldap、zcm-nexus、zcm-zcip、zcm-zcipapi`
```
helm install zcm-cicd zcm-icicd/zcm-cicd -n zcm9 -f values.yaml
helm install zcm-cicd-task zcm-icicd/zcm-cicd-task -n zcm9 -f values.yaml
helm install zcm-cloudtest zcm-icicd/zcm-cloudtest -n zcm9 -f values.yaml
helm install zcm-devspace zcm-icicd/zcm-devspace -n zcm9 -f values.yaml
helm install zcm-gitea zcm-icicd/zcm-gitea -n zcm9 -f values.yaml
helm install zcm-ldap zcm-icicd/zcm-ldap -n zcm9 -f values.yaml
helm install zcm-nexus zcm-icicd/zcm-nexus -n zcm9 -f values.yaml
helm install zcm-zcip zcm-icicd/zcm-zcip -n zcm9 -f values.yaml
helm install zcm-zcipapi zcm-icicd/zcm-zcipapi -n zcm9 -f values.yaml
```
### minio（可选）
```
见minio/README.md
```

## 升级
将以上`install`关键字替换为`upgrade`

## 卸载
### zcm-system-env
```
helm uninstall zcm-env-base -n zcm9
helm uninstall zcm-env-local -n zcm9
helm uninstall zcm-env-cluster -n zcm9
helm uninstall zcm-env-nms -n zcm9
helm uninstall zcm-env-cicd -n zcm9
```
### zcm-system-base
```
helm uninstall zcm-system-base -n zcm9
```
### zcm-ibase
```
helm uninstall zcm-ansible -n zcm9
helm uninstall zcm-cmdb -n zcm9
helm uninstall zcm-dingding -n zcm9
helm uninstall zcm-midware-yum -n zcm9
helm uninstall zcm-portal -n zcm9
helm uninstall zcm-zcamp -n zcm9
helm uninstall zcm-zcamp-rest-server -n zcm9
```
### zcm-iplatform
```
helm uninstall zcm-application -n zcm9
helm uninstall zcm-baas -n zcm9
helm uninstall zcm-image -n zcm9
helm uninstall zcm-resource -n zcm9
helm uninstall zcm-service -n zcm9
helm uninstall zcm-ssc -n zcm9
helm uninstall zcm-tool -n zcm9
```
### zcm-imonitor
```
helm uninstall nms-activemq -n zcm9
helm uninstall nms-grafana -n zcm9
helm uninstall nms-influxdb -n zcm9
helm uninstall nms-kapacitor -n zcm9
helm uninstall nms-metrics -n zcm9
helm uninstall nms-monitor -n zcm9
helm uninstall zcm-dialing -n zcm9
```
### zcm-imanager
```
helm uninstall zcm-zcachemanager -n zcm9
helm uninstall zcm-zdaasmanager -n zcm9
helm uninstall zcm-zmqmanager -n zcm9
```
### zcm-icicd
```
helm uninstall zcm-cicd -n zcm9
helm uninstall zcm-cicd-task -n zcm9
helm uninstall zcm-cloudtest -n zcm9
helm uninstall zcm-devspace -n zcm9
helm uninstall zcm-gitea -n zcm9
helm uninstall zcm-ldap -n zcm9
helm uninstall zcm-nexus -n zcm9
helm uninstall zcm-zcip -n zcm9
helm uninstall zcm-zcipapi -n zcm9
```
