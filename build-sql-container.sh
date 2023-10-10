#!/bin/bash
set -euo pipefail

# Check if docker container is running
if docker ps -a | grep -q 'mysqltodo'; then
    echo "Removing existing mysqltodo container"
    docker stop mysqltodo
    docker rm mysqltodo
    # docker volume rm mysqltodo # Use this if you want to remove the associated volumes
fi

# Check if docker network 'todo-app' exists
if ! docker network ls | grep -q 'todo-app'; then
    docker network create todo-app
fi

docker run -d                                   \
    --network todo-app --network-alias mysql    \
    -v todo-mysql-data:/var/lib/mysql           \
    -e MYSQL_ROOT_PASSWORD="${1}"               \
    -e MYSQL_DATABASE=todos                     \
    --name mysqltodo                            \
    mysql:5.7

echo "MySQL container started successfully."