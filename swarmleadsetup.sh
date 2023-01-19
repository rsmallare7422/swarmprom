#!/usr/bin/env bash

# This script sets up the swarm lead manager by creating the necessary external config files and ENV variables 
# for the stack deployment.
#
# NOTE: The COMMIT_HASH is needed so it is imperative that this is executed inside the cloned repo directory.
#
shopt -s expand_aliases
source $HOME/.env
export GODEBUG=x509ignoreCN=0

# Set ENV GIT COMMIT HASH var
export COMMIT_HASH=`git --git-dir=.git rev-parse --short=8 HEAD`

# Create config files

#blackbox.yml config
docker config create BLACKBOX_EXPORTER_${COMMIT_HASH} ./blackbox-exporter/config/testdata/blackbox.yml



