FROM docker:18-dind

RUN echo "Install build dependencies" && \
      apk update && \
      apk add --no-cache --virtual .deps \
        build-base \
        gcc \
        libc-dev \
        libffi-dev \
        linux-headers \
        musl-dev \
        openssl-dev \
        python3-dev && \
  echo "Install OS dependencies" && \
      apk add --no-cache \
        bash \
        curl \
        docker-compose \
        make \
        python3 && \
  echo "Symlink python3 dependencies to python" && \
      ln -s /usr/bin/python3 /usr/bin/python && \
      ln -s /usr/bin/pip3    /usr/bin/pip && \
  echo "Install Ansible" && \
      pip install --no-cache-dir \
        ansible==2.7.10 \
        awscli \
        pyyaml && \
  echo "Cleanup" && \
      apk del .deps

COPY dockerd-entrypoint.sh /