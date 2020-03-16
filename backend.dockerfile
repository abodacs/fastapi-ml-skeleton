FROM python:3.7

ENV LANG C.UTF-8
# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# For development, Jupyter remote kernel, Hydrogen
# Using inside the container:
# jupyter lab --ip=0.0.0.0 --allow-root --NotebookApp.custom_display_url=http://127.0.0.1:8888
ARG env=prod
RUN bash -c "if [ $env == 'dev' ] ; then pip install jupyterlab ; fi"

# set working directory
WORKDIR /usr/src/

COPY docker/requirements.txt /tmp/
RUN python -m pip install -r /tmp/requirements.txt

COPY docker/start.sh /usr/local/bin/
COPY docker/start-reload.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/start.sh && \
    chmod +x /usr/local/bin/start-reload.sh

COPY ./fastapi_skeleton /usr/src/fastapi_skeleton/

ENV PYTHONPATH=/usr/src/fastapi_skeleton/

EXPOSE 8888

CMD /usr/local/bin/start-reload.sh
# ENTRYPOINT ["/usr/local/bin/entrypoint.sh"] used with when adding DB
