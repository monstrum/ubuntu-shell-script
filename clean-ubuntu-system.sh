#!/bin/bash

# Clean npm/yarn/composer cache
npm cache clean --force
yarn cache clean
composer clear-cache

# Clean logs
sudo rm -rf /var/log/*.gz
sudo rm -rf /var/log/*.old
sudo rm -rf /var/log/**/*.gz
