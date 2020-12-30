ARG PG_VERSION
FROM postgres:$PG_VERSION

# hadolint ignore=DL3008
RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
      apt-utils \
      bzip2 \
      curl \
      ca-certificates \
      openssh-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    truncate -s 0 /var/log/*log

RUN localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8

COPY files/init.sh /docker-entrypoint-initdb.d/init.sh
