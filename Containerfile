FROM almalinux:9 as builder
ENV HUGO_VERSION=0.121.2
WORKDIR /app
RUN curl -L -o hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz &&\
    tar xf hugo.tar.gz &&\
    rm hugo.tar.gz
COPY . .
