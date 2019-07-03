#!/bin/bash -e

INSTANCE_ID=${1}

[[ "${INSTANCE_ID}" = "" ]] && {
  echo -e "Please provide an instance ID(s)" ; exit 2
}

echo -e "Fetching IP address of instance ${INSTANCE_ID}"
IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --output text --query 'Reservations[*].Instances[*].[PublicIpAddress]')

echo -e "Fetching swarm NodeID for ${INSTANCE_ID} at ${IP}"
SWARM_NODE_ID=$(ssh ec2-user@$IP "docker info --format '{{.Swarm.NodeID}}'")

echo -e "NodeID: ${SWARM_NODE_ID}"

echo -e "Setting node to availability: drain"
ssh $(make access-manager-instance) "docker node update --availability drain ${SWARM_NODE_ID}" > /dev/null

echo -e "Stopping containers on node"
STOPPED_COUNT=$(ssh ec2-user@${IP} 'docker stop --time 120 `docker ps -q` 2>/dev/null | wc -l' || true)

echo -e "Stopped ${STOPPED_COUNT} containers on node"
