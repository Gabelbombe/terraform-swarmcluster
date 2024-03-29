#!/bin/bash

GROUP_QUERY="AutoScalingGroups[*].Instances[*].InstanceId"
INSTANCE_QUERY="Reservations[*].Instances[*]"

[[ "$2" != "" ]] && {
  INSTANCE_QUERY="${INSTANCE_QUERY}.${2}" ; exit 2
}

INSTANCES=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names "${1}" --output text --query "${GROUP_QUERY}")

aws ec2 describe-instances                          \
  --filters Name=instance-state-name,Values=running \
  --instance-ids ${INSTANCES}                       \
  --output text                                     \
  --query "${INSTANCE_QUERY}"
