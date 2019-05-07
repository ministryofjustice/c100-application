#!/usr/bin/env bash

DATABASE_URL=$1
DRY_RUN=$2

if [[ -z "$DATABASE_URL" ]]; then
  echo "Usage: ${0} [DATABASE_URL]"
  exit 1
fi

echo -e "Status of database BEFORE the restore ...\n"
psql -d ${DATABASE_URL} -f tables_info.sql


if [[ -z "$DRY_RUN" ]]; then

  echo -e "Restoring latest.dump ...\n"
  pg_restore --verbose --clean --no-acl --no-owner -d ${DATABASE_URL} latest.dump

  echo -e "Status of database AFTER the restore ...\n"
  psql -d ${DATABASE_URL} -f tables_info.sql

else

  echo -e "DRY-RUN detected. Checking integrity if dump, without restoring ...\n"
  pg_restore latest.dump > /dev/null

fi

echo "--- Restore completed ---"
