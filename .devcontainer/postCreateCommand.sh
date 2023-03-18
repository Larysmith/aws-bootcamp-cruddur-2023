#!/usr/bin/env bash
# npm install frontend
cd /workspaces/aws-bootcamp-cruddur-2023/frontend-react-js npm update -g && npm i;
# backend pip requirements
cd /workspaces/aws-bootcamp-cruddur-2023/backend-flask pip3 install -r requirements .txt;
# Postg resql
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt S(lsb_release -cs) -pgdg main"
wget --quiet -O - https : //www. postgresqI.org/media/keys/ACCC4CF8.asc I sudo apt-key add -
sudo apt-get update -y;
sudo apt install -y postgresql-client-13 libpq-dev
> /etc/apt/sources. list .d/pgdg. list' -;
sudo apt-get update -y;
sudo apt install -y postgresql -client -13 libpq-dev
