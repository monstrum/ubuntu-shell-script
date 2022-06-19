#!/bin/bash

# Clean npm/yarn/composer cache
npm cache clean --force
yarn cache clean
composer clear-cache

# Clean logs
sudo rm -rf /var/log/*.gz
sudo rm -rf /var/log/*.old
sudo rm -rf /var/log/**/*.gz

# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS
set -eu

LANG=en_US.UTF-8 snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done

sudo rm -rf /var/lib/snapd/cache/*

# Clean incompleted install
sudo apt-get autoremove
sudo apt-get autoclean
sudo apt-get clean
sudo apt-get remove

docker container prune -f
docker volume prune -f
docker network prune -f

# High cpu usage ubuntu
# https://forums.docker.com/t/dockerd-using-100-cpu/94962
# Clean up corrupt json-log
sudo find /var/lib/docker/containers/ -name *-json.log -exec bash -c 'jq '.' {} > /dev/null 2>&1 || echo "file corrupt: {}"' \;
sudo find /var/lib/docker/containers/ -name *-json.log -exec mv {} ~/logs-backup \;
