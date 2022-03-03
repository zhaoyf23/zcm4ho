## minio

minio chart包。

chart模块：
```
minio
```
预置条件：需要部署minio的节点需要具备label
```
# kubectl label node 172.16.17.126 zcm-cos=zcm-cos
```
预置镜像：
```
# docker pull 10.45.80.1/zcm9/bitnami-shell:10-debian-10-r198
# docker pull 10.45.80.1/zcm9/minio:2021.9.18-debian-10-r0
# docker pull 10.45.80.1/zcm9/minio-client:2021.9.2-debian-10-r17
```
默认情况下，版本包中需要预置镜像文件，通过AIK一键部署时，会将镜像解压并推送到实际harbor仓库中，如172.16.85.51:52800，在安装前，需要执行以下命令替换values.yaml中的值。
```
sed -i 's/10.45.80.1/172.16.85.51:52800/g' values.yaml
```
### 1.单机版：适用于1台主机
```
# helm install minio minio -n zcm9
# kubectl get svc -n zcm9 | grep minio
minio                                NodePort    10.254.18.186    <none>        9000:52251/TCP,9001:52261/TCP             107s
```
访问地址：`http://172.16.17.126:52135/`
### 2.双机版：适用于2台主机
```
# helm install minio minio -n zcm9
# helm install minio-2 minio -n zcm9
# kubectl get svc -n zcm9 | grep minio
minio                                NodePort    10.254.18.186    <none>        9000:52251/TCP,9001:52261/TCP             107s
minio-2                              NodePort    10.254.109.174   <none>        9000:52252/TCP,9001:52262/TCP             70s
```
nodePort端口采用固定端口。访问地址：`http://172.16.17.126:52261/`和`http://172.16.17.126:52262/`。

### 3.高可用版：适用于4台主机【暂不支持】
