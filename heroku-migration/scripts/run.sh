#!/usr/bin/env bash

DRY_RUN="${DRY_RUN}"
HEROKU_APP="${HEROKU_APP}"
HEROKU_API_KEY="${HEROKU_API_KEY}"
DATABASE_URL="${DATABASE_URL}"

./backup.sh ${HEROKU_APP} ${DRY_RUN} && ./restore.sh ${DATABASE_URL} ${DRY_RUN}
