#!/bin/bash

PLAY_HOME=/srv/play-1.2.4
PLAY=$PLAY_HOME/play

APP_BASE_PATH=/srv/rlb/application/shells
APPLICATION_PATH=$APP_BASE_PATH/current
SHARED_APPLICATION_PATH=$APP_BASE_PATH/shared
PIDFILE=$SHARED_APPLICATION_PATH/pids/play.pid
PLAY_START_LOG=${SHARED_APPLICATION_PATH}/log/play_start.log

RETVAL=0

start() {
    echo $PATH
    echo -n "Starting Play service: "
    cd ${APPLICATION_PATH}
    date > ${PLAY_START_LOG}
    ${PLAY} dependencies --sync >> ${PLAY_START_LOG}
    ${PLAY} evolutions:apply >> ${PLAY_START_LOG}
    ${PLAY} start --pid_file=${PIDFILE} >> ${PLAY_START_LOG} &
    RETVAL=$?

    exit ${RETVAL}
}
stop() {
    echo -n "Shutting down Play! service: "
    cd ${APPLICATION_PATH}
    if [ -f ${PIDFILE} ]; then
        kill `cat ${PIDFILE}`
        RETVAL=$?
        if test $RETVAL != 0; then
            echo "The process in the pidfile was not running. If Play! is running with a different PID, YOU NEED TO KILL THE PLAY PROCESS MANUALLY since it occupies the needed ports. We now delete ${PIDFILE}"
        else
            echo "Shut down Play! succesfully."
        fi
        rm -f ${PIDFILE}
    else
        echo -n "No play.pid pidfile found. Assumed Play was not running."
    fi
}
status() {
    cd  ${APPLICATION_PATH}
    ${PLAY} status --pid_file=${PIDFILE}
    RETVAL=$?
}
clean() {
    rm -f ${PIDFILE}
}
case "$1" in
    start)
    clean
    start
    ;;
    stop)
    stop
    clean
    ;;
    restart|reload)
    stop
    sleep 10
    start
    ;;
    status)
    status
    ;;
    clean)
    clean
    ;;
    *)
    echo "Usage: $0 { start | stop | restart | status } { production | acceptance }"
esac
exit 0
