#!/bin/bash

set -e

usermod -u ${USER_ID:-1000} ${CONTAINER_USER} > /dev/null 2>&1
chown -R ${USER_ID:-1000} /home/${CONTAINER_USER}

exec "$@"
