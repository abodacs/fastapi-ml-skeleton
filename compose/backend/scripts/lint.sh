#!/usr/bin/env bash

set -e
set -x


flake8 ./backend/fastapi_skeleton --exclude=./backend/fastapi_skeleton/db/migrations
mypy ./backend/fastapi_skeleton

black --check ./backend/fastapi_skeleton --diff
isort --recursive --check-only ./backend/fastapi_skeleton
