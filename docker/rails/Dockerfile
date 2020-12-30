ARG RUBY_VERSION

FROM ruby:$RUBY_VERSION-slim-buster

ARG PG_MAJOR_VERSION
ARG BUNDLER_VERSION

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
      build-essential \
      curl \
      git \
      gnupg \
      less && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    truncate -s 0 /var/log/*log

RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" $PG_MAJOR_VERSION > /etc/apt/sources.list.d/pgdg.list

# hadolint ignore=DL3008
RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
      "postgresql-client-$PG_MAJOR_VERSION" \
      "postgresql-server-dev-$PG_MAJOR_VERSION" && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    truncate -s 0 /var/log/*log

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    GEM_HOME=/bundle
ENV BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    BUNDLE_PATH=${GEM_HOME} \
    BUNDLE_BIN=${GEM_HOME}/bin \
    BUNDLE_APP_CONFIG=${GEM_HOME}

RUN gem update --system &&\
    gem install "bundler:$BUNDLER_VERSION"

ENV PATH=/app/bin:$BUNDLE_BIN:$PATH

RUN mkdir -p /app
WORKDIR /app

# https://github.com/ufoscout/docker-compose-wait
ARG COMPOSE_WAIT_VERSION=2.7.3
RUN curl -SL "https://github.com/ufoscout/docker-compose-wait/releases/download/${COMPOSE_WAIT_VERSION}/wait" -o /wait
RUN chmod +x /wait
