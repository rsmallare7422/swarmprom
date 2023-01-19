#!/usr/bin/env bash

# This script updates the service blackbox exporter
#
# NOTE: The COMMIT_HASH is needed so it is imperative that this is executed inside the cloned repo directory.
#
# shopt -s expand_aliases
# source $HOME/.env
export GODEBUG=x509ignoreCN=0

# Set ENV GIT COMMIT HASH var
export COMMIT_HASH=`git --git-dir=.git rev-parse --short=8 HEAD`

# Set ENV BLACKBOX_EXPORTER_${OLD_COMMIT_HASH}
export BLACKBOX_EXPORTER_OLD=BLACKBOX_EXPORTER_${COMMIT_HASH}

# Create new config file blackbox.yml config with the update
docker config create BLACKBOX_EXPORTER_${COMMIT_HASH} ./blackbox-exporter/config/testdata/blackbox.yml

# Update the service
docker service update --force \
   --config-add source=BLACKBOX_EXPORTER_${COMMIT_HASH},target=/config/blackbox.yml \
   --config-rm ${BLACKBOX_EXPORTER_OLD} \
   thd_blackbox-exporter
