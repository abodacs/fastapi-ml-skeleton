FROM python:3.8.2-slim-buster

ENV LANG C.UTF-8
# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# For development, Jupyter remote kernel, Hydrogen
# Using inside the container:
# jupyter lab --ip=0.0.0.0 --allow-root --NotebookApp.custom_display_url=http://127.0.0.1:8888
ARG env=prod
RUN bash -c "if [ $env == 'dev' ] ; then pip install jupyterlab ; fi"
RUN apt-get update && python -m pip install --upgrade pip && \
    apt-get install --no-install-recommends --no-install-suggests -y \
    libproj-dev gdal-bin libgeoip1 libgeoip-dev gettext python-dev && \
    rm -rf /var/lib/apt/lists/* && apt clean

# Copy only requirements, to cache them in docker layer:
WORKDIR /pysetup
COPY ./backend/pyproject.toml ./backend/poetry.lock /pysetup/

RUN pip install poetry==1.0.*
ENV PATH = "${PATH}:/root/.poetry/bin"

RUN poetry config  virtualenvs.create false && \
  poetry install $(test "$env" == prod && echo "--no-dev") --no-interaction --no-ansi

# set working directory
RUN adduser  -disabled-password  --gecos "" --home /app appuser

COPY ./backend /app


COPY compose/backend /usr/local/bin/

RUN chmod +x /usr/local/bin/start.sh && \
    chmod +x /usr/local/bin/start-reload.sh


# RUN sudo chown -R celery:celery celerybeat-schedule
# RUN chmod 775 socket/
# RUN chown -R appuser:appuser socket

USER appuser
WORKDIR /app

USER root
# use until solve Permission issue

ENV PYTHONPATH=/app

EXPOSE 8888
STOPSIGNAL SIGINT

CMD /usr/local/bin/start-reload.sh
# ENTRYPOINT ["/usr/local/bin/entrypoint.sh"] used with when adding DB
