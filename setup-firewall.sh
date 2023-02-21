#!/bin/bash

echo "*** Firewall - open ports for cluster comunication!"
sudo systemctl start firewalld
firewall-cmd --add-port=2377/tcp --permanent
firewall-cmd --add-port=4789/udp --permanent
firewall-cmd --add-port=7946/tcp --permanent
firewall-cmd --add-port=7946/udp --permanent

echo "*** Firewall - open port 8080 ..."
firewall-cmd --permanent --add-port=8080/tcp
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload
