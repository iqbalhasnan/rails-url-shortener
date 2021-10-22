#!/bin/bash

# This script automates destroying and rebuilding all docker containers
#
# The main goal is to help run tests against a fresh environment both on
# local and on CI

set -xeuo pipefail

# docker-compose service groups
tasks_group=(web_yarn web_bundler)

# Destroy everything
docker-compose stop
docker-compose rm -f
docker network prune --force
docker-compose ps


# Run setup tasks like bundler & yarn
docker-compose up "${tasks_group[@]}"

docker-compose ps "${tasks_group[@]}"
if docker-compose ps "${tasks_group[@]}" | grep -v 'Exit 0' | grep 'Exit'; then
    echo "Failed running setup tasks."
    exit 1
fi

# Bring up web services
docker-compose up -d web

# Show status
docker-compose ps "${tasks_group[@]}" web postgres

echo "Done."