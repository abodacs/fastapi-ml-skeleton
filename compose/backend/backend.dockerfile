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

RUN apt-get update && pip install --upgrade pip && \
    apt-get install --no-install-recommends --no-install-suggests -y && \
    rm -rf /var/lib/apt/lists/* && apt clean
# RUN apt-get -y install sudo
RUN pip install pydevd-pycharm~=201.6487.18

COPY backend/requirements.txt /appuser/requirements.txt
RUN python -m pip install -r /appuser/requirements.txt --no-cache-dir

# set working directory
RUN adduser  \
    --disabled-password \
    --gecos "" \
    --home /app \
    appuser

COPY compose/backend /usr/local/bin/

RUN chmod +x /usr/local/bin/start.sh && \
    chmod +x /usr/local/bin/start-reload.sh


# RUN sudo chown -R celery:celery celerybeat-schedule
# RUN chmod 775 socket/
# RUN chown -R appuser:appuser socket

USER appuser
COPY ./backend /app
WORKDIR /app

USER root
# use until solve Permission issue

ENV PYTHONPATH=/app

EXPOSE 8888
STOPSIGNAL SIGINT

CMD /usr/local/bin/start-reload.sh
# ENTRYPOINT ["/usr/local/bin/entrypoint.sh"] used with when adding DB
