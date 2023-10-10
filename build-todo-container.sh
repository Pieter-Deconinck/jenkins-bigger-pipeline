#!/bin/bash
set -euo pipefail

# Check if tempdir already exists and create it if it doesnt
if [ ! -d "tempdir" ]; then
    mkdir tempdir
fi

# Check if docker container is running
if docker ps -a | grep -q 'todoapp'; then
    echo "Removing existing todoapp container"
    docker stop todoapp
    docker rm todoapp
fi

cd tempdir || exit

git clone https://github.com/Pieter-Deconinck/getting-started.git 

cd getting-started/app || exit

cat > Dockerfile << _EOF_
FROM node:20-alpine
RUN apk add --no-cache python3 g++ make
WORKDIR /app
COPY . .
RUN yarn install --production
CMD ["node", "/app/src/index.js"]
_EOF_

docker build -t getting-started .
docker run -dp 3000:3000                    \
  --network todo-app                        \
  -e MYSQL_HOST=mysql                       \
  -e MYSQL_USER=root                        \
  -e MYSQL_PASSWORD=Pieter2023              \
  -e MYSQL_DB=todos                         \
  --name todoapp                            \
  getting-started

echo "todoapp container started successfully."
