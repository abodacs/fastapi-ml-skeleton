#! /usr/bin/env sh
# Exit in case of error
set -e

echo "Running inside /usr/src/app/prestart.sh, you could add migrations to this file, e.g.:"

echo "
#! /usr/bin/env bash
# Let the DB start
sleep 10;
# Run migrations
alembic upgrade head
"