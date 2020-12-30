#!/usr/bin/env bash
psql -v ON_ERROR_STOP=1 --u "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER hotwire WITH PASSWORD 'hotwired' CREATEDB;
    CREATE DATABASE hotwire_sandbox_development WITH OWNER hotwire ENCODING 'UTF8' LC_COLLATE 'C' LC_CTYPE 'C' TEMPLATE template0;
EOSQL
