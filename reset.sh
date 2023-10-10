#!/bin/bash

set -euo pipefail

# Check for .NET repo $ delete
DIR="p3ops-demo-app"
if [ -d "$DIR" ]; then
     rm -r "$DIR"
fi


# Check for SQL container & delete
if  docker ps -q --filter name=sqlpreview; then
    echo "Removing sqlpreview container"
    sudo docker stop sqlpreview
    sudo docker rm sqlpreview
fi
