#!/bin/bash

sudo apt-get -y update
sudo apt install -y docker.io
sudo apt install -y curl
sudo apt install -y python3-pip
sudo apt install -y nginx
sudo apt install -y certbot
sudo add-apt-repository -y ppa:certbot/certbot
sudo apt-get -y update
sudo apt install -y python-certbot-nginx
    