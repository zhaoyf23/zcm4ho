#!/bin/sh
source ./aik.properties
if ( [ ! $1 ] || [ ! $2 ] || [ ! $3 ] || [ ! $4 ] ); then
  echo "missing parameters, DBHOST/DBUSER/DBPORT/DBPASS"
  exit -1;
fi
DBHOST=$1
DBUSER=$2
DBPORT=$3
DBPASS=$4
echo "install_create_user.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_create_user.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "install_sql_service_center.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_sql_service_center.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "install_zcm_cicd.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_zcm_cicd.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "install_zcm_cluster_container.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_zcm_cluster_container.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "install_zcm_cmdb.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_zcm_cmdb.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "install_zcm_common.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_zcm_common.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "install_zcm_daily.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_zcm_daily.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "install_zcm_devspace.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_zcm_devspace.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "install_zcm_dialing.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_zcm_dialing.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "install_zcm_dingding.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_zcm_dingding.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "install_zcm_grafana.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_zcm_grafana.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "install_zcm_grafpub.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_zcm_grafpub.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "install_zcm_middleware.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_zcm_middleware.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "install_zcm_nms.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_zcm_nms.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "install_zcm_portal_9.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_zcm_portal_9.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "install_zcm_scp.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_zcm_scp.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "install_zcm_service.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_zcm_service.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "install_zcm_task.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_zcm_task.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "install_zcm_tool.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_zcm_tool.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "install_zcm_zcamp.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_zcm_zcamp.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "install_zcm_itracing.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/init_script/install_zcm_itracing.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "update_zcm_cicd.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/update_script/update_zcm_cicd.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "update_zcm_cluster_container.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/update_script/update_zcm_cluster_container.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "update_sql_service_center.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/update_script/update_sql_service_center.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "update_zcm_cmdb.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/update_script/update_zcm_cmdb.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "update_zcm_collect.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/update_script/update_zcm_collect.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "update_zcm_common.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/update_script/update_zcm_common.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "update_zcm_daily.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/update_script/update_zcm_daily.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "update_zcm_devspace.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/update_script/update_zcm_devspace.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "update_zcm_dialing.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/update_script/update_zcm_dialing.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "update_zcm_dingding.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/update_script/update_zcm_dingding.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "update_zcm_grafana.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/update_script/update_zcm_grafana.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "update_zcm_grafpub.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/update_script/update_zcm_grafpub.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "update_zcm_middleware.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/update_script/update_zcm_middleware.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "update_zcm_nms.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c -f --default-character-set=utf8 < ./Database/update_script/update_zcm_nms.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "update_zcm_portal_9.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/update_script/update_zcm_portal_9.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "update_zcm_scp.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/update_script/update_zcm_scp.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "update_zcm_service.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/update_script/update_zcm_service.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "update_zcm_tool.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/update_script/update_zcm_tool.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
echo "update_zcm_zcamp.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/update_script/update_zcm_zcamp.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi
if [ -d ./Database/update_script/merge ]; then
  rm -rf ./Database/update_script/merge
fi
mkdir -p ./Database/update_script/merge
echo "merge sql_service_center"
echo "use sql_service_center;" >> ./Database/update_script/merge/merge_sql_service_center.sql
ls -l ./Database/update_script/ZSmart_ZCM_V9*sql_service_center*.sql | awk '{print $NF}' | sort -n -t '.' -k 4 | while read a
do
  cat $a >> ./Database/update_script/merge/merge_sql_service_center.sql
done
echo "merge zcm_cicd"
echo "use zcm_cicd;" >> ./Database/update_script/merge/merge_zcm_cicd.sql
ls -l ./Database/update_script/ZSmart_ZCM_V9*zcm_cicd*.sql | awk '{print $NF}' | sort -n -t '.' -k 4 | while read a
do
  cat $a >> ./Database/update_script/merge/merge_zcm_cicd.sql
done
echo "merge zcm_cluster_container"
echo "use zcm_cluster_container;" >> ./Database/update_script/merge/merge_zcm_cluster_container.sql
ls -l ./Database/update_script/ZSmart_ZCM_V9*zcm_cluster_container*.sql | awk '{print $NF}' | sort -n -t '.' -k 4 | while read a
do
  cat $a >> ./Database/update_script/merge/merge_zcm_cluster_container.sql
done
echo "merge zcm_cmdb"
echo "use zcm_cmdb;" >> ./Database/update_script/merge/merge_zcm_cmdb.sql
ls -l ./Database/update_script/ZSmart_ZCM_V9*zcm_cmdb*.sql | awk '{print $NF}' | sort -n -t '.' -k 4 | while read a
do
  cat $a >> ./Database/update_script/merge/merge_zcm_cmdb.sql
done
echo "merge zcm_common"
echo "use zcm_common;" >> ./Database/update_script/merge/merge_zcm_common.sql
ls -l ./Database/update_script/ZSmart_ZCM_V9*zcm_common*.sql | awk '{print $NF}' | sort -n -t '.' -k 4 | while read a
do
  cat $a >> ./Database/update_script/merge/merge_zcm_common.sql
done
echo "merge zcm_daily"
echo "use zcm_daily;" >> ./Database/update_script/merge/merge_zcm_daily.sql
ls -l ./Database/update_script/ZSmart_ZCM_V9*zcm_daily*.sql | awk '{print $NF}' | sort -n -t '.' -k 4 | while read a
do
  cat $a >> ./Database/update_script/merge/merge_zcm_daily.sql
done
echo "merge zcm_devspace"
echo "use zcm_devspace;" >> ./Database/update_script/merge/merge_zcm_devspace.sql
ls -l ./Database/update_script/ZSmart_ZCM_V9*zcm_devspace*.sql | awk '{print $NF}' | sort -n -t '.' -k 4 | while read a
do
  cat $a >> ./Database/update_script/merge/merge_zcm_devspace.sql
done
echo "merge zcm_dialing"
echo "use zcm_dialing;" >> ./Database/update_script/merge/merge_zcm_dialing.sql
ls -l ./Database/update_script/ZSmart_ZCM_V9*zcm_dialing*.sql | awk '{print $NF}' | sort -n -t '.' -k 4 | while read a
do
  cat $a >> ./Database/update_script/merge/merge_zcm_dialing.sql
done
echo "merge zcm_dingding"
echo "use zcm_dingding;" >> ./Database/update_script/merge/merge_zcm_dingding.sql
ls -l ./Database/update_script/ZSmart_ZCM_V9*zcm_dingding*.sql | awk '{print $NF}' | sort -n -t '.' -k 4 | while read a
do
  cat $a >> ./Database/update_script/merge/merge_zcm_dingding.sql
done
echo "merge zcm_grafana"
echo "use zcm_grafana;" >> ./Database/update_script/merge/merge_zcm_grafana.sql
ls -l ./Database/update_script/ZSmart_ZCM_V9*zcm_grafana*.sql | awk '{print $NF}' | sort -n -t '.' -k 4 | while read a
do
  cat $a >> ./Database/update_script/merge/merge_zcm_grafana.sql
done
echo "merge zcm_grafpub"
echo "use zcm_grafpub;" >> ./Database/update_script/merge/merge_zcm_grafpub.sql
ls -l ./Database/update_script/ZSmart_ZCM_V9*zcm_grafpub*.sql | awk '{print $NF}' | sort -n -t '.' -k 4 | while read a
do
  cat $a >> ./Database/update_script/merge/merge_zcm_grafpub.sql
done
echo "merge zcm_middleware"
echo "use zcm_middleware;" >> ./Database/update_script/merge/merge_zcm_middleware.sql
ls -l ./Database/update_script/ZSmart_ZCM_V9*zcm_middleware*.sql | awk '{print $NF}' | sort -n -t '.' -k 4 | while read a
do
  cat $a >> ./Database/update_script/merge/merge_zcm_middleware.sql
done
echo "merge zcm_nms"
echo "use zcm_nms;" >> ./Database/update_script/merge/merge_zcm_nms.sql
ls -l ./Database/update_script/ZSmart_ZCM_V9*zcm_nms*.sql | awk '{print $NF}' | sort -n -t '.' -k 4 | while read a
do
  cat $a >> ./Database/update_script/merge/merge_zcm_nms.sql
done
echo "merge zcm_portal_9"
echo "use zcm_portal_9;" >> ./Database/update_script/merge/merge_zcm_portal_9.sql
ls -l ./Database/update_script/ZSmart_ZCM_V9*zcm_portal_9*.sql | awk '{print $NF}' | sort -n -t '.' -k 4 | while read a
do
  cat $a >> ./Database/update_script/merge/merge_zcm_portal_9.sql
done
echo "merge zcm_scp"
echo "use zcm_scp;" >> ./Database/update_script/merge/merge_zcm_scp.sql
ls -l ./Database/update_script/ZSmart_ZCM_V9*zcm_scp*.sql | awk '{print $NF}' | sort -n -t '.' -k 4 | while read a
do
  cat $a >> ./Database/update_script/merge/merge_zcm_scp.sql
done
echo "merge zcm_service"
echo "use zcm_service;" >> ./Database/update_script/merge/merge_zcm_service.sql
ls -l ./Database/update_script/ZSmart_ZCM_V9*zcm_service*.sql | awk '{print $NF}' | sort -n -t '.' -k 4 | while read a
do
  cat $a >> ./Database/update_script/merge/merge_zcm_service.sql
done
echo "merge zcm_task"
echo "use zcm_task;" >> ./Database/update_script/merge/merge_zcm_task.sql
ls -l ./Database/update_script/ZSmart_ZCM_V9*zcm_task*.sql | awk '{print $NF}' | sort -n -t '.' -k 4 | while read a
do
  cat $a >> ./Database/update_script/merge/merge_zcm_task.sql
done
echo "merge zcm_tool"
echo "use zcm_tool;" >> ./Database/update_script/merge/merge_zcm_tool.sql
ls -l ./Database/update_script/ZSmart_ZCM_V9*zcm_tool*.sql | awk '{print $NF}' | sort -n -t '.' -k 4 | while read a
do
  cat $a >> ./Database/update_script/merge/merge_zcm_tool.sql
done
echo "merge zcm_zcamp"
echo "use zcm_zcamp;" >> ./Database/update_script/merge/merge_zcm_zcamp.sql
ls -l ./Database/update_script/ZSmart_ZCM_V9*zcm_zcamp*.sql | awk '{print $NF}' | sort -n -t '.' -k 4 | while read a
do
  cat $a >> ./Database/update_script/merge/merge_zcm_zcamp.sql
done
echo "merge_*.sql"
ls -l ./Database/update_script/merge/merge_*.sql | awk '{print $NF}' | sort -n -t '.' -k 4 | while read a
do
  mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < $a
  if [ $? -ne 0 ]
  then
      echo "failed"
      exit -1;
  fi
done
echo "zcm_custom_script.sql"
mysql -h ${DBHOST} -P ${DBPORT} -u ${DBUSER} --password=${DBPASS} -c --default-character-set=utf8 < ./Database/zcm_custom_script.sql
if [ $? -ne 0 ]
then
    echo "failed"
    exit -1;
fi

