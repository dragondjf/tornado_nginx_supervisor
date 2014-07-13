#!/bin/sh

showprocessinfo(){
    sleep 2
    ps -aux|grep supervisord
    ps -aux|grep main.py
    ps -aux|grep nginx
}

stop(){
    sleep 2
    echo " ******start kill supervisord process*******"
    processid=`pgrep  supervisord`
    echo "supervisord pid is:   $processid"
    if [ $processid ]; then
        kill $processid
        echo " ******kill supervisord process OK!*******"
    fi
    sleep 2
    echo "******start kill nginx process*******"
    nginxsid=`pgrep nginx`
    echo $nginxsid
    for pid in $nginxsid; do
        if [ $pid ]; then
            kill $pid #statements
        fi
    done
    echo "******kill nginx process OK!*******"  
}

start(){
    echo "******start supervisord process*******"
    supervisord
    nginx
    echo "******start supervisord process OK*******"
}

restart(){
    stop
    start
}


showprocessinfo
case $1 in  
        start | begin)  
            restart
        ;;  
        stop | end)  
            stop
        ;;  
        *)  
          echo "ignore"  
        ;;  
esac 
showprocessinfo