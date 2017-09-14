#!/bin/bash

set -e

CONTAINER_USER=rails
CONTAINER_USER_ID=${USER_ID:-6666}

if id "${CONTAINER_USER}" > /dev/null 2>&1; then
  usermod -u ${CONTAINER_USER_ID} ${CONTAINER_USER} > /dev/null 2>&1
else
  useradd -o -u ${CONTAINER_USER_ID} -m -s /bin/bash ${CONTAINER_USER}
fi

chmod 777 ${GEM_HOME}

exec gosu ${CONTAINER_USER} "$@"
