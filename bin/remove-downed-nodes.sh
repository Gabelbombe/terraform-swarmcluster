#!/bin/bash -e

CMD_FIND_NODES='docker node inspect --format "{{.Status.State}}:{{.ID}}" $(docker node ls -q) | grep "^down" | cut -d ":" -f2'

NODES=$(ssh `make swarm-managers` $CMD_FIND_NODES)

echo -e "Demoting: $NODES"

ssh $(make swarm-manager) "docker node demote $NODES"

echo -e "Removing: $NODES"
ssh $(make swarm-manager) "docker node rm $NODES"
