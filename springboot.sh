#!/bin/bash
# your application jar file.
FILE=/path/helloworld.jar
# your app name, in case there many apps in the same envoriment.
APP=helloworld

# PID file.
PID=/tmp/$APP.pid

# start function.
function start(){
    echo "Starting..."
    if [ -f $PID ] && [ -n $PID ]; then
        if ps -p `cat $PID` > /dev/null; then
            echo "Already running"
            exit 0;
        fi
    fi
    nohup java -jar $FILE > $APP.log 2>&1 &
    echo $! > $PID
    echo "Started."
}

# stop 
function stop(){
    if [ -f $PID ]; then
        kill $(cat $PID)
        rm /tmp/$APP.pid
        echo "Stopped."
    else
        echo "Not running or not found pid file."
    fi
}

# restart
function restart() {
    stop
    start
}


case $1 in
        start)
            start
        ;;
        stop)
            stop
        ;;
        restart)
            restart
        ;;
esac
