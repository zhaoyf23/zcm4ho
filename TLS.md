创建名为 gke-ip 的全局静态 IP 地址，请运行以下命令：
```
[wct.zyongfang@zcm-dev oss-hogke]$ gcloud compute addresses create gke-ip --global
Created [https://www.googleapis.com/compute/v1/projects/wct-oss-dev/global/addresses/gke-ip].
```
如需查找您创建的静态 IP 地址，请运行以下命令：
gcloud compute addresses describe gke-ip --global
```
[wct.zyongfang@zcm-dev oss-hogke]$ gcloud compute addresses describe gke-ip --global
address: 35.241.36.210
addressType: EXTERNAL
creationTimestamp: '2022-03-22T21:54:26.904-07:00'
description: ''
id: '4350137030254466797'
ipVersion: IPV4
kind: compute#address
name: gke-ip
networkTier: PREMIUM
selfLink: https://www.googleapis.com/compute/v1/projects/wct-oss-dev/global/addresses/gke-ip
status: RESERVED
```
