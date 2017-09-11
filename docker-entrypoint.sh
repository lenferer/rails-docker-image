#!/bin/bash

set -e

if [[ -n "${USER_ID}" ]]; then
  usermod -u ${USER_ID} ${CONTAINER_USER}
fi

if [[ -n "${GROUP_ID}" ]]; then
  groupmod -g ${GROUP_ID} ${CONTAINER_USER}
fi

exec "$@"
