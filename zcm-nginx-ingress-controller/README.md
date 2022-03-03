## zcm-nginx-ingress-controller

该项目是ZCM AIK部署过程中的zcm-nginx-ingress-controller组件。从官网下载指定版本的`nginx-ingress-controller`，基于此镜像进一步构建适用于zcm的镜像。

Dockerfile文件

```
FROM quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.30.0
COPY ./httpfiles/ /zcm/httpfiles/
```

构建方法

`docker build -t 10.45.80.1/zcm9/ingress-nginx-controller:v0.30.0 -f Dockerfile .`

该目录下所属文件在[gitlab](http://gitlab.iwhalecloud.com/zcm-muiltcloud/zcm-nginx-ingress-controller) 上维护。
