#!/usr/bin/env bash

cd {{ postgres_owner_info.home }}/{{ postgres_ws }}

DUMPDATE=$(date +"%Y-%m-%dT%H-%M-%SZ")
DBDUMPNAME="postgres-{{ ansible_facts['hostname'] }}-$DUMPDATE.sql"

DUMPCMD="pg_dumpall -U postgres -E UTF8 -f /backup/$DBDUMPNAME"

docker compose start database

docker compose exec -u root database /bin/bash -c "$DUMPCMD"
sudo chown {{ postgres_backup_user_info.name }}:{{ postgres_backup_user_info.group }} {{ postgres_owner_info.home }}/{{ postgres_ws }}/backup/$DBDUMPNAME

mv {{ postgres_owner_info.home }}/{{ postgres_ws }}/backup/* {{ postgres_backup_user_info.home }}/{{ postgres_backup_ws }}
