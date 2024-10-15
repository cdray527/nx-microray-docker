#!/bin/bash

COMPOSE_FILE=~/Documents/nx-microray/nx-microray-docker/docker-compose.yml

case "$1" in
    up)
        echo "Starting all containers..."
        docker-compose -f $COMPOSE_FILE up -d
        ;;
    down)
        echo "Stopping all containers..."
        docker-compose -f $COMPOSE_FILE down
        ;;
    restart)
        echo "Restarting all containers..."
        docker-compose -f $COMPOSE_FILE down
        docker-compose -f $COMPOSE_FILE up -d
        ;;
    build)
        if [ -n "$2" ]; then
            echo "Building container $2..."
            docker-compose -f $COMPOSE_FILE build $2
        else
            echo "Building all containers..."
            docker-compose -f $COMPOSE_FILE build
        fi
        ;;
    cleanup)
        echo "Clean up dangling volumes..."
        VOLUMES=$(docker volume ls -q --filter dangling=true)
        VOLUMES=$(echo "$VOLUMES" | grep -v 'testray-postgres-data' | grep -v 'nx-microray-mongodb-data')
        if [ -n "$VOLUMES" ]; then
            docker volume rm $VOLUMES
            echo "Removed dangling volumes."
        else
            echo "No dangling volumes found."
        fi
        ;;
    *)
        echo "Usage: $0 {up|down|restart|build|cleanup}"
        exit 1
esac