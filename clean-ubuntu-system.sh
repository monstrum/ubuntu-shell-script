#!/bin/bash

# Clean npm/yarn/composer cache
npm cache clean --force
yarn cache clean
composer clear-cache
