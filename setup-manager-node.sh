#!/bin/bash

echo "*** Remove from cluster if it is already part of a swarm ..."
docker swarm leave -f

echo "*** Initialize it as the first node of the cluster ..."
HOSTNAME_IP=$(hostname -i | awk '{print $2}')
[ -z "$HOSTNAME_IP" ] && HOSTNAME_IP=$(hostname -i | awk '{print $1}') 
docker swarm init --advertise-addr $HOSTNAME_IP

echo "*** Saving the cluster token into shared folder file ..."
CLUSTER_TOKEN=$(docker swarm join-token -q worker)
echo "Token: $CLUSTER_TOKEN"
echo $CLUSTER_TOKEN > /vagrant/token

echo "*** Creating swarm secrets ..."
docker secret rm db-root-password -
echo '12345' | docker secret create db-root-password -
