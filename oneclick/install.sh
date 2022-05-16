#!/bin/sh
source ./config

install() {
  # install docker
  sudo yum install docker-ce docker-ce-cli -y
  # install mysql-client
  sudo yum install mysql -y
  # install kubectl
  sudo yum install kubectl -y
  # install helm
  sudo cp ../helm /usr/bin/helm
  sudo chmod +x /usr/bin/helm
}

init_docker() {
  systemctl enable docker
  systemctl start docker
  if [ $? -ne 0 ]; then
    echo "failed start docker"
    exit 1
  fi
}

image() {
  if ( [ -z "$source_artifact" ] || [ -z "$dest_artifact" ] )
    echo "source_artifact or dest_artifact cannot be null, please edit config file"
    exit 1
  fi
  gcloud auth configure-docker $(echo ${source_artifact} | awk -F "/" '{print $1}')
  docker pull ${source_artifact}/itracing-flink-standalone:C_20210927191815
  docker pull ${source_artifact}/itracing-zookeeper:C_20210927192503
  docker pull ${source_artifact}/itracing-collector:C_20210927192038
  docker pull ${source_artifact}/itracing-elasticsearch:C_20210927191814
  docker pull ${source_artifact}/itracing-esconsole:C_20210927191841
  docker pull ${source_artifact}/itracing-hbase-standalone:C_20210927191812
  docker pull ${source_artifact}/itracing-kafka:C_20211020145638
  docker pull ${source_artifact}/itracing-kibana:C_20210927191815
  docker pull ${source_artifact}/itracing-log:C_20211018150747
  docker pull ${source_artifact}/itracing-logstash:C_20210927191817
  docker pull ${source_artifact}/itracing-tuning-web:C_20210927191901
  docker pull ${source_artifact}/itracing-web:C_20211108192943
  docker pull ${source_artifact}/nms-activemq:C_20210927190250
  docker pull ${source_artifact}/nms-grafana:C_20220223132153-7.2.1
  docker pull ${source_artifact}/nms-kapacitor:C_20220223132145
  docker pull ${source_artifact}/nms-metrics:C_20220310160136
  docker pull ${source_artifact}/nms-monitor:C_20211013152857
  docker pull ${source_artifact}/zcm-ansible:C_20220228104348
  docker pull ${source_artifact}/zcm-application:C_20220311132739
  docker pull ${source_artifact}/zcm-cmdb:C_20220310183207
  docker pull ${source_artifact}/zcm-dialing:C_20220223132153
  docker pull ${source_artifact}/zcm-dingding:C_20220303131530
  docker pull ${source_artifact}/zcm-midware-yum:C_20210927190247
  docker pull ${source_artifact}/zcm-portal:T_20220406111254
  docker pull ${source_artifact}/redis:3.2.12
  docker pull ${source_artifact}/zcm-resource:C_20220223142949
  docker pull ${source_artifact}/zcm-service:C_20220309110355
  docker pull ${source_artifact}/zcm-ssc:C_20220310110037
  docker pull ${source_artifact}/zcm-tool:C_20220309153737
  docker pull ${source_artifact}/zcm-zcamp:C_20220308092440
  docker pull ${source_artifact}/zcm-zcamp-rest-server:C_20220223170335
  docker images | grep ${source_artifact} | awk '{print "docker tag "$3" "$1":"$2}' | sed -i 's|${source_artifact}|${dest_artifact}|g' | sh
  gcloud auth configure-docker $(echo ${dest_artifact} | awk -F "/" '{print $1}')
  docker images | grep ${dest_artifact} | awk '{print "docker push "$1":"$2}' | sh
}

init_mysql_script() {
  sh import_sql.sh ${ZCM_MYSQL_HOST} ${ZCM_MYSQL_USER} ${ZCM_MYSQL_PORT} ${ZCM_MYSQL_PASSWORD}
}

init_gke() {
  kubectl get node
  if [ $? -ne 0 ]; then
    echo "failed connect gke."
    exit 1
  fi
  if [ $(kubectl get namespace | grep zcm9 | wc -l) -eq 0 ]; then
    kubectl create namespace zcm9
  fi
  kubectl create secret tls zcm-tls-secret --cert ../zcm-nginx-ingress-controller/iwhalecloud_com.crt --key ../zcm-nginx-ingress-controller/iwhalecloud.com.key -n zcm9
  if [ -f ../zcm-nginx-ingress-controller/mandatory.yaml ]; then
    rm -rf ../zcm-nginx-ingress-controller/mandatory.yaml
  fi
  cp ../zcm-nginx-ingress-controller/mandatory-tpl.yaml ../zcm-nginx-ingress-controller/mandatory.yaml
  sed -i "s|image:\ 10.45.80.1/zcm9|image:\ ${dest_artifact}|g" ../zcm-nginx-ingress-controller/mandatory.yaml
  kubectl apply -f ../zcm-nginx-ingress-controller/mandatory.yaml
  kubectl apply -f ../zcm-nginx-ingress-controller/ingress-nginx-controller-admission.yaml
  for i in {1..50}; do
    sleep 10
    num=$(kubectl get pod -o wide -n zcm9 | grep ingress-nginx-controller | grep 1/1 | grep Running | wc -l)
    echo "Wait ingress-nginx-controller healthy. Times: $i"
    if [ $num -ge 1 ]; then
      echo "ingress-nginx-controller is healthy."
      break
    fi
  done
  kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
  kubectl apply -f ../zcm-nginx-ingress-controller/ingress/ingress-tcp.yaml
}

init_chart() {
  find ./charts/zcm-system-env -type f -print0 | xargs -0 sed -i "s/10.176.112.31/${ZCM_MYSQL_HOST}/g"
  find ./charts/zcm-system-env -type f -print0 | xargs -0 sed -i "s/ZCM_MYSQL_USER: zcm/ZCM_MYSQL_USER: ${ZCM_MYSQL_USER}/g"
  find ./charts/zcm-system-env -type f -print0 | xargs -0 sed -i "s/3306/${ZCM_MYSQL_PORT}/g"
  sed -i "s/e2NpcGhlcn17cnNhfVIvOFRyZkNaVm9QMFRua0YvZ3RyN0orbW5NY2Z0bEtIMnUzaHVubjZNaW89/${ZCM_MYSQL_PASSWORD_RSA}/g" ./charts/zcm-system-base/charts/zcm-mysql/values.yaml
  if [ -d /zcm/charts ]; then
    sudo rm -rf /zcm/charts
  fi
  sudo cp -R ../charts /zcm
  sudo cp ../values.yaml /zcm/charts
}

release() {
  cd /zcm/charts
  helm install zcm-env-base zcm-system-env/zcm-env-base -n zcm9 -f values.yaml
  helm install zcm-env-cicd zcm-system-env/zcm-env-cicd -n zcm9 -f values.yaml
  helm install zcm-env-cluster zcm-system-env/zcm-env-cluster -n zcm9 -f values.yaml
  helm install zcm-env-local zcm-system-env/zcm-env-local -n zcm9 -f values.yaml
  helm install zcm-env-nms zcm-system-env/zcm-env-nms -n zcm9 -f values.yaml

  helm install zcm-system-base zcm-system-base -n zcm9 -f values.yaml

  helm install zcm-ansible zcm-ibase/zcm-ansible -n zcm9 -f values.yaml
  helm install zcm-cmdb zcm-ibase/zcm-cmdb -n zcm9 -f values.yaml
  helm install zcm-dingding zcm-ibase/zcm-dingding -n zcm9 -f values.yaml
  helm install zcm-midware-yum zcm-ibase/zcm-midware-yum -n zcm9 -f values.yaml
  helm install zcm-portal zcm-ibase/zcm-portal -n zcm9 -f values.yaml
  helm install zcm-zcamp zcm-ibase/zcm-zcamp -n zcm9 -f values.yaml
  helm install zcm-zcamp-rest-server zcm-ibase/zcm-zcamp-rest-server -n zcm9 -f values.yaml

  helm install zcm-application zcm-iplatform/zcm-application -n zcm9 -f values.yaml
  helm install zcm-image zcm-iplatform/zcm-image -n zcm9 -f values.yaml
  helm install zcm-resource zcm-iplatform/zcm-resource -n zcm9 -f values.yaml
  helm install zcm-service zcm-iplatform/zcm-service -n zcm9 -f values.yaml
  helm install zcm-ssc zcm-iplatform/zcm-ssc -n zcm9 -f values.yaml
  helm install zcm-tool zcm-iplatform/zcm-tool -n zcm9 -f values.yaml

  helm install nms-activemq zcm-imonitor/nms-activemq -n zcm9 -f values.yaml
  helm install nms-grafana zcm-imonitor/nms-grafana -n zcm9 -f values.yaml
  helm install nms-kapacitor zcm-imonitor/nms-kapacitor -n zcm9 -f values.yaml
  helm install nms-metrics zcm-imonitor/nms-metrics -n zcm9 -f values.yaml
  helm install nms-monitor zcm-imonitor/nms-monitor -n zcm9 -f values.yaml
  helm install zcm-dialing zcm-imonitor/zcm-dialing -n zcm9 -f values.yaml
  cd -
}
