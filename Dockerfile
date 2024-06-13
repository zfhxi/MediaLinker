FROM alpine:latest

# 环境变量
ENV LANG="C.UTF-8" \
    TZ="Asia/Shanghai" \
    NGINX_PORT="8091" \
    NGINX_SSL_PORT="8095" \
    REPO_URL="https://github.com/chen3861229/embyExternalUrl" \
    SSL_ENABLE="false" \
    SSL_CRON="0 /2   " \
    SSL_DOMAIN="" \
    AUTO_UPDATE="false" \
    SOURCE_COMMIT_ID="218ff73" \
    SERVER="emby"

# 安装git
RUN apk --no-cache add nginx nginx-mod-http-js curl busybox git openssl && \
    mkdir -p /var/cache/nginx/emby/image /opt && \
    git clone $REPO_URL /embyExternalUrl && \
    curl -L -o /tmp/lego_latest.tar.gz "https://github.com/go-acme/lego/releases/download/v3.7.0/lego_v3.7.0_linux_amd64.tar.gz" && \
    tar zxvf /tmp/lego_latest.tar.gz -C /tmp && \
    chmod 755 /tmp/lego && \
    mv /tmp/lego / && \
    rm -rf /tmp/*

COPY entrypoint /entrypoint
COPY start_server /start_server
COPY check_certificate /check_certificate

RUN chmod +x /entrypoint /start_server /check_certificate
RUN mkdir /template
COPY config /template/config
COPY scripts /scripts
RUN chmod -R +x /template /scripts 
RUN apk add --no-cache grep
RUN cd /embyExternalUrl && git checkout $SOURCE_COMMIT_ID

ENTRYPOINT ["/bin/sh", "/entrypoint"]