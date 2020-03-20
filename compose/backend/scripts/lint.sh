#!/usr/bin/env bash

set -e
set -x


flake8 fastapi_skeleton --exclude=fastapi_skeleton/db/migrations
mypy fastapi_skeleton

black --check fastapi_skeleton --diff
isort --recursive --check-only fastapi_skeleton
