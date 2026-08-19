#!/usr/bin/env bash

cd {{ postgres_owner_info.home }}/{{ postgres_ws }}

DUMPDATE=$(date +"%Y-%m-%dT%H-%M-%SZ")

{% for target in postgres_native_db_backup_targets %}
DBDUMPNAME="{{ target.name }}-{{ ansible_facts['hostname'] }}-$DUMPDATE{% if target.version_string is defined %}-{{ target.version_string }}{% endif %}.sql"
pg_dump --format=plain {{ target.name }} -U {{ postgres_backup_user_info.name }} -E UTF8 -f {{ postgres_backup_user_info.home }}/{{ postgres_backup_ws }}/$DBDUMPNAME
chown {{ postgres_backup_user_info.name }}:{{ postgres_backup_user_info.group }} {{ postgres_backup_user_info.home }}/{{ postgres_backup_ws }}/$DBDUMPNAME

{% endfor %}
