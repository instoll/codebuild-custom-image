FROM docker:19-dind

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
        jq \
        git \
        make \
        nodejs \
        npm \
        python3 \
        yarn \
        zip && \
    echo "Install yq" && \
      wget https://github.com/mikefarah/yq/releases/download/3.3.0/yq_linux_amd64 -O /usr/bin/yq && \
      chmod 0755 /usr/bin/yq && \
    echo "Symlink python3 dependencies to python" && \
      ln -s /usr/bin/python3 /usr/bin/python && \
      ln -s /usr/bin/pip3    /usr/bin/pip && \
    echo "Install Ansible" && \
      pip install --no-cache-dir \
        ansible \
        awscli \
        docker-compose \
        PyGithub \
        pyyaml && \
    echo "Cleanup" && \
      apk del .deps
