#!/bin/bash

# Database connection variables for non-prod database
DB_NAME="${POSTGRES_DB}"
DB_USER="${POSTGRES_USER}"
DB_PASSWORD="${POSTGRES_PASSWORD}"

# Foreign database connection variables
FOREIGN_DB_HOST="prod_postgres"
FOREIGN_DB_PORT="5432"

# Schema variables
FOREIGN_SCHEMA="raw"
RAW_SCHEMA="foreign_raw"

# SQL commands for logging configuration
SQL_LOGGING_COMMANDS="
-- Set logging parameters
ALTER SYSTEM SET log_statement = 'all';
ALTER SYSTEM SET log_destination = 'stderr';  # Direct logs to stderr (can be seen in docker logs)
ALTER SYSTEM SET log_directory = '/var/log/postgresql';  # Log directory
-- You can add more logging options as required
"

# SQL commands
SQL_COMMANDS="
CREATE EXTENSION IF NOT EXISTS postgres_fdw;
CREATE SERVER IF NOT EXISTS $FOREIGN_DB_HOST FOREIGN DATA WRAPPER postgres_fdw OPTIONS (dbname '${POSTGRES_DB}', host '$FOREIGN_DB_HOST', port '$FOREIGN_DB_PORT');
CREATE USER MAPPING IF NOT EXISTS FOR CURRENT_USER SERVER $FOREIGN_DB_HOST OPTIONS (user '$DB_USER', password '$DB_PASSWORD');
IMPORT FOREIGN SCHEMA $FOREIGN_SCHEMA FROM SERVER $FOREIGN_DB_HOST INTO public;
ALTER SCHEMA public RENAME TO $RAW_SCHEMA;
"

# Execute SQL commands using psql
psql -U $DB_USER -d $DB_NAME -c "$SQL_COMMANDS"
# Execute SQL commands using psql
psql -U $DB_USER -d $DB_NAME -c "$SQL_LOGGING_COMMANDS"
