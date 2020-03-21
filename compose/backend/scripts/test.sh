#!/usr/bin/env bash

set -e
set -x

pytest --cov=./backend/fastapi_skeleton --cov=tests --cov-report=term-missing --cov-config=./backend/setup.cfg ${@}
