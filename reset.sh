#!/bin/bash

set -euo pipefail

# Check for .NET repo $ delete
DIR="/home/vagrant/jenkins-bigger-pipeline"
if [ -d "$DIR" ]; then
    sudo rm -r "$DIR"
fi


# Check for SQL container & delete
if sudo docker ps -q --filter name=sqlpreview; then
    echo "Removing sqlpreview container"
    sudo docker stop sqlpreview
    sudo docker rm sqlpreview
fi
