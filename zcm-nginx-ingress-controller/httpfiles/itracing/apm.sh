#!/bin/bash

set +e

export ITRACING_COLLECTOR_IP="172.16.17.122";
export ITRACING_SAMPLING_RATE=1;
export ITRACING_AGENT_URL="http://172.16.17.122:52000/httpfiles/itracing/pinpoint-agent-1.7.3.tar.gz"
export ITRACING_AGENT_ZK_HOST="172.16.17.125:52181"
export ITRACING_AGENT_PP_WEB_URL="http://172.16.17.125:52984/"

oldpath=`pwd`
logfile=$HOME/log/apm.log
mkdir -p $HOME/log

# for tomcat application
if [ ! -z $TOMCAT_HOME ];then
    if [ ! -f /root/APM/apm_flag ];then
        touch /root/APM/apm_flag
        mkdir /root/APM/pinpoint-agent
        curl -f -o /tmp/pinpoint-agent-1.7.3.tar.gz --connect-timeout 10 --max-time 30 $ITRACING_AGENT_URL
        result=$?
        if [ $result -eq 0 ];then
            echo $(date +%F_%T) "curl: download pinpoint-agent successfull" |tee $logfile
            mv /tmp/pinpoint-agent-1.7.3.tar.gz /root/APM/pinpoint-agent/pinpoint-agent-1.7.3.tar.gz
cd /root/APM/pinpoint-agent
            tar -xzvf pinpoint-agent-1.7.3.tar.gz
            rm -rf pinpoint-agent-1.7.3.tar.gz
            ## tuning sample rate
            sed -i "s|profiler.sampling.rate=1|profiler.sampling.rate=$ITRACING_SAMPLING_RATE|g" /root/APM/pinpoint-agent/pinpoint.config
            ## disable interceptor for gson and jackon
            sed -i 's|profiler.json.jackson=true|profiler.json.jackson=false|g' /root/APM/pinpoint-agent/pinpoint.config
            sed -i 's|profiler.json.gson=true|profiler.json.gson=false|g' /root/APM/pinpoint-agent/pinpoint.config
            ## collector address
            sed -i "s|profiler.collector.ip=127.0.0.1|profiler.collector.ip=$ITRACING_COLLECTOR_IP|g" /root/APM/pinpoint-agent/pinpoint.config
             #sed -i "s|profiler.collector.span.port=9996|profiler.collector.span.port=52940|g" /root/APM/pinpoint-agent/pinpoint.config
             #sed -i "s|profiler.collector.stat.port=9995|profiler.collector.stat.port=52930|g" /root/APM/pinpoint-agent/pinpoint.config
            # sed -i "s|profiler.collector.tcp.port=9994|profiler.collector.tcp.port=52920|g" /root/APM/pinpoint-agent/pinpoint.config
            ## agent visualization
            sed -i "s|profiler.nbrtrace.enable=false|profiler.nbrtrace.enable=true|g"  /root/APM/pinpoint-agent/pinpoint.config
            sed -i "s|profiler.zookeeper.address=172.18.233.38:2181,172.18.233.39:2181|profiler.zookeeper.address=$ITRACING_AGENT_ZK_HOST|g" /root/APM/pinpoint-agent/pinpoint.config
            sed -i "s|^pinpoint.web.url=.*|pinpoint.web.url=ITRACING_AGENT_PP_WEB_URL|g" /root/APM/pinpoint-agent/pinpoint.config
            ## enable resttemplate plugin
            sed -i "s|profiler.resttemplate=false|profiler.resttemplate=true|g" /root/APM/pinpoint-agent/pinpoint.config
            ## set false to avoid conflict with springboot embeded tomcat
            sed -i "s|profiler.tomcat.conditional.transform=true|profiler.tomcat.conditional.transform=false|g"  /root/APM/pinpoint-agent/pinpoint.config
            sed -i "s|profiler.tomcat.excludeurl=/aa/test.html, /bb/exclude.html|profiler.tomcat.excludeurl=/favicon.ico, /**/*.js, /**/*.jsp, /**/*.html, /**/*.png, /**/*.jpg, /**/*.gif|g" /root/APM/pinpoint-agent/pinpoint.config
            ## enable log breakthrough
            sed -i 's|profiler.logback.logging.transactioninfo=false|profiler.logback.logging.transactioninfo=true|g' /root/APM/pinpoint-agent/pinpoint.config
            sed -i 's|profiler.log4j.logging.transactioninfo=false|profiler.log4j.logging.transactioninfo=true|g' /root/APM/pinpoint-agent/pinpoint.config
        else
            echo $(date +%F_%T) "curl: download pinpoint-agent failed, return code : $result" |tee $logfile
            rm -rf /root/APM/apm_flag
        fi
    fi
    current=`date "+%Y-%m-%d %H:%M:%S"`
    timeStamp=`date -d "$current" +%s`
    currentTimeStamp=$((timeStamp*1000+10#`date "+%N"`/1000000))
    container_ip=`hostname -i|sed 's/\./ /g'|xargs printf "%03d%03d%03d%03d"`_$currentTimeStamp
    if [ -f /root/APM/pinpoint-agent/pinpoint-bootstrap-1.7.3.jar ];then
        export JAVA_OPTS="-javaagent:/root/APM/pinpoint-agent/pinpoint-bootstrap-1.7.3.jar -Dpinpoint.agentId=$container_ip -Dpinpoint.applicationName=$CLOUD_APP_NAME $JAVA_OPTS"
    fi
else
# for general java application
    case $apm_type in
      "pinpoint")
        if [ ! -f /root/APM/apm_flag ]
          then
            touch /root/APM/apm_flag
            mkdir /root/APM/pinpoint-agent
            curl -f -o /tmp/pinpoint-agent-1.7.3.tar.gz --connect-timeout 10 --max-time 30 $ITRACING_AGENT_URL
            result=$?
            if [ $result -eq 0 ];then
                echo $(date +%F_%T) "curl: download pinpoint-agent successfull" |tee $logfile
                mv /tmp/pinpoint-agent-1.7.3.tar.gz /root/APM/pinpoint-agent/pinpoint-agent-1.7.3.tar.gz
cd /root/APM/pinpoint-agent
                tar -xzvf pinpoint-agent-1.7.3.tar.gz
                rm -rf pinpoint-agent-1.7.3.tar.gz
                source /root/docker-app.def
                eval conf=\${${APP}[0]}
                pin_conf=`echo $conf | awk -F " " '{print $NF}'`
                ## tuning sample rate
                sed -i "s|profiler.sampling.rate=1|profiler.sampling.rate=$ITRACING_SAMPLING_RATE|g" /root/APM/pinpoint-agent/pinpoint.config
                ## disable interceptor for gson and jackon
                sed -i 's|profiler.json.jackson=true|profiler.json.jackson=false|g' /root/APM/pinpoint-agent/pinpoint.config
                sed -i 's|profiler.json.gson=true|profiler.json.gson=false|g' /root/APM/pinpoint-agent/pinpoint.config
                ## collector address
                sed -i "s|profiler.collector.ip=127.0.0.1|profiler.collector.ip=$ITRACING_COLLECTOR_IP|g" /root/APM/pinpoint-agent/pinpoint.config
                 #sed -i "s|profiler.collector.span.port=9996|profiler.collector.span.port=52940|g" /root/APM/pinpoint-agent/pinpoint.config
                 #sed -i "s|profiler.collector.stat.port=9995|profiler.collector.stat.port=52930|g" /root/APM/pinpoint-agent/pinpoint.config
                 #sed -i "s|profiler.collector.tcp.port=9994|profiler.collector.tcp.port=52920|g" /root/APM/pinpoint-agent/pinpoint.config
                ## agent visualization
                sed -i "s|profiler.nbrtrace.enable=false|profiler.nbrtrace.enable=true|g"  /root/APM/pinpoint-agent/pinpoint.config
                sed -i "s|profiler.zookeeper.address=172.18.233.38:2181,172.18.233.39:2181|profiler.zookeeper.address=$ITRACING_AGENT_ZK_HOST|g" /root/APM/pinpoint-agent/pinpoint.config
                sed -i "s|^pinpoint.web.url=.*|pinpoint.web.url=ITRACING_AGENT_PP_WEB_URL|g" /root/APM/pinpoint-agent/pinpoint.config
                ## enable resttemplate plugin
                sed -i "s|profiler.resttemplate=false|profiler.resttemplate=true|g" /root/APM/pinpoint-agent/pinpoint.config
                ## setup tomcat startup name
                sed -i "s|profiler.tomcat.bootstrap.main=org.apache.catalina.startup.Bootstrap|profiler.tomcat.bootstrap.main=$pin_conf|g" /root/APM/pinpoint-agent/pinpoint.config
                ## set false to avoid conflict with springboot embeded tomcat
                sed -i "s|profiler.tomcat.conditional.transform=true|profiler.tomcat.conditional.transform=false|g"  /root/APM/pinpoint-agent/pinpoint.config
                sed -i "s|profiler.tomcat.excludeurl=/aa/test.html, /bb/exclude.html|profiler.tomcat.excludeurl=/favicon.ico, /**/*.js, /**/*.jsp, /**/*.html, /**/*.png, /**/*.jpg, /**/*.gif|g" /root/APM/pinpoint-agent/pinpoint.config
                ## enable log breakthrough
                sed -i "s|profiler.logback.logging.transactioninfo=false|profiler.logback.logging.transactioninfo=true|g" /root/APM/pinpoint-agent/pinpoint.config
                sed -i 's|profiler.log4j.logging.transactioninfo=false|profiler.log4j.logging.transactioninfo=true|g' /root/APM/pinpoint-agent/pinpoint.config
            else
                echo $(date +%F_%T) "curl: download pinpoint-agent failed, return code : $result" |tee $logfile
                rm -rf /root/APM/apm_flag
            fi
        fi
        current=`date "+%Y-%m-%d %H:%M:%S"`
        timeStamp=`date -d "$current" +%s`
        currentTimeStamp=$((timeStamp*1000+10#`date "+%N"`/1000000))
        container_ip=`hostname -i|sed 's/\./ /g'|xargs printf "%03d%03d%03d%03d"`_$currentTimeStamp
        if [ -f /root/APM/pinpoint-agent/pinpoint-bootstrap-1.7.3.jar ];then
            java_opts="-javaagent:/root/APM/pinpoint-agent/pinpoint-bootstrap-1.7.3.jar -Dpinpoint.agentId=$container_ip -Dpinpoint.applicationName=$CLOUD_APP_NAME $JAVA_OPTS"
        fi
        ;;

        *)
        ;;
    esac
    export java_opts
fi

cd $oldpath


