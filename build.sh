#!/bin/bash

set -euo pipefail


# Create Microsoft SQL docker container
docker run -e "ACCEPT_EULA=Y" \
                -e "MSSQL_SA_PASSWORD=Pieter2023" \
                -e "MSSQL_PID=Evaluation" \
                -p 1433:1433  \
                --name sqlpreview \
                --hostname sqlpreview \
                -d mcr.microsoft.com/mssql/server:2022-preview-ubuntu-22.04

# Pull github repo


git clone https://github.com/Pieter-Deconinck/p3ops-demo-app

# Build .NET app
dotnet restore p3ops-demo-app/src/Server/Server.csproj

# Run .NET app
dotnet run watch --project p3ops-demo-app/src/Server/Server.csproj
proj
