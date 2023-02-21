#!/bin/bash

HOSTNAME_IP=$(hostname -i | awk '{print $2}')
[ -z "$HOSTNAME_IP" ] && HOSTNAME_IP=$(hostname -i | awk '{print $1}') 

echo "*** Remove from cluster if it is already part of a swarm ..."
docker swarm leave -f

echo "*** Try to join '$HOSTNAME_IP' as a worker to the swarm cluster ..."
if [ -f "/vagrant/token" ]; then
    echo "*** Joining the node as a worker the the swarm cluster ..."
    CLUSTER_TOKEN=$(head -n 1 /vagrant/token)
    echo "Token: $CLUSTER_TOKEN"
    docker swarm join --token $CLUSTER_TOKEN --advertise-addr $HOSTNAME_IP 192.168.34.111:2377
else 
    echo "Token wasn't found ..."
fi
