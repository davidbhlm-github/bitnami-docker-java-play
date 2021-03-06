#!/bin/bash
set -e

# Set default values
export PLAY_PROJECT_NAME=${PLAY_PROJECT_NAME:-"myapp"}
export PLAY_TEMPLATE=${PLAY_TEMPLATE:-"play-java"}
export PLAY_PROJECT_PORT=${PLAY_PROJECT_PORT:-"9000"}

PROJECT_DIRECTORY=/app/$PLAY_PROJECT_NAME

log () {
    echo -e "\033[0;33m$(date "+%H:%M:%S")\033[0;37m ==> $1."
}

if [ "$1" == "activator" -a "$4" == "~run" ] ; then
    if [ ! -d $PROJECT_DIRECTORY ] ; then
      log "Creating example Play application"
      nami execute activator createProject --force $PLAY_PROJECT_NAME $PLAY_TEMPLATE
      log "Play app created"
    else 
	  log "App already created"
    fi
fi

cd $PROJECT_DIRECTORY

exec /entrypoint.sh "$@"
