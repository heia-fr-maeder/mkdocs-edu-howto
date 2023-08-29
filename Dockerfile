FROM python:bullseye as builder
WORKDIR /app
COPY . /app

RUN apt-get update && \
        export DEBIAN_FRONTEND=noninteractive && \
        apt-get -y install --no-install-recommends \
      python3-brotli \
      python3-cffi \
      python3-pip \
      zip \
      curl \
      gettext
RUN pip install poetry==1.6.1
RUN poetry config virtualenvs.in-project true
RUN python -V
RUN poetry install --no-root

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && mkdir -p ~/.kube/
