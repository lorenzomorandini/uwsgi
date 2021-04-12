FROM python:3.9-slim-buster

RUN apt-get update && apt-get install -y nginx gcc gosu uwsgi-plugin-python3=2.0.18-1 \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean && apt-get autoremove \
    # forward request and error logs to docker log collector
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

RUN pip3 install uwsgi==2.0.18

RUN useradd --no-create-home nginx && useradd --no-create-home uwsgi

COPY docker /docker/
COPY nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["/docker/entrypoint.sh"]
CMD ["nginx"]
