#!/bin/bash

# General Packages
sudo apt-get update
sudo apt-get install influxdb-client mosquitto-clients ffmpeg make 

# Docker
# Tbd

# Docker Compose
# Tbd

# Ich Gitlab Repository
cd ~/ich/
git clone https://github.com/bacabhome/www.git homeassistant/www
git clone https://github.com/bacabhome/plex.git homeassistant/www/plex/
git clone https://gitlab.com/bosques-urbanos/iikim/iikim.git
docker-compose pull
docker-compose build

# Services
cd ~/ich/services
docker-compose build

# Iikim Applications
cd ~/ich/iikim
docker-compose build

# Intel OpenVINO Toolkit
cd ~/ich/iikim/openvino
make demo-cpu

# Stacks
docker pull clearlinux/stacks-dlrs_2-mkl
cd ~/ich/iikim/stacks/dlrs
make demo-cpu

# InfluxDB Database
cd ~/ich
docker-compose up -d influxdb
sleep 5
influx -execute 'CREATE DATABASE home_assistant'
# curl -XPOST 'http://172.17.0.1:8086/query' --data-urlencode 'q=CREATE DATABASE home_assistant'

# Home Assistant Secrets File Configuration
cp config/homeassistant/secrets.yaml homeassistant/

# Ich
docker-compose up -d
