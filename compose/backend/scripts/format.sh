#!/usr/bin/env bash

set -e

isort --recursive  --force-single-line-imports fastapi_skeleton tests
autoflake --recursive --remove-all-unused-imports --remove-unused-variables --in-place fastapi_skeleton tests
black fastapi_skeleton tests
isort --recursive fastapi_skeleton tests
