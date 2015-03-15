FROM python:2.7.9
MAINTAINER Massimiliano Ravelli <massimiliano.ravelli@gmail.com>

RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi

RUN    gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && apt-get update \
    && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/* \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && pip install uWSGI==2.0.9 \
    && apt-get purge -y --auto-remove curl

COPY docker-entrypoint.sh /

EXPOSE 5432

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["uwsgi"]
