#!/usr/bin/env bash

HEROKU_APP=$1
DRY_RUN=$2

if [[ -z "$HEROKU_APP" ]]; then
  echo "Usage: ${0} [HEROKU_APP]"
  exit 1
fi

if [[ -z "$HEROKU_API_KEY" ]]; then
  echo "HEROKU_API_KEY not found in the environment"
  exit 1
fi

if [[ -z "$DRY_RUN" ]]; then
  heroku maintenance:on -a ${HEROKU_APP}
fi

echo -e "Current status of database in ${HEROKU_APP} ...\n"
heroku pg:psql -a ${HEROKU_APP} -f tables_info.sql

heroku pg:backups:capture -a ${HEROKU_APP}
heroku pg:backups:download -a ${HEROKU_APP}

if [[ -z "$DRY_RUN" ]]; then
  heroku maintenance:off -a ${HEROKU_APP}
fi

echo "--- Backup completed ---"
