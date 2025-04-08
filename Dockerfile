# 依赖 curl 和 jq，需要在构建阶段安装
FROM alpine:3.21 AS fetcher

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk update && \
    apk add --no-cache curl jq && \
    curl -s "https://api.github.com/repos/fatedier/frp/releases" | jq -r '.[1].tag_name' > /tmp/version.txt

FROM alpine:3.21 AS build

# 从 fetcher 复制 version.txt 并设置 ENV
COPY --from=fetcher /tmp/version.txt /tmp/version.txt

# COPY --from=fetcher /tmp/version.txt /tmp/
# 在单个 RUN 指令中完成下载、解压、清理操作
RUN LATEST_VERSION=$(cat /tmp/version.txt | tr -d '\r\n') \
    && echo "FRP Version: ${LATEST_VERSION}" \
    && VERSION_SIMPLE=${LATEST_VERSION#v} \
    && wget -q "https://github.com/fatedier/frp/releases/download/${LATEST_VERSION}/frp_${VERSION_SIMPLE}_linux_amd64.tar.gz" -O /frp.tar.gz \
    && mkdir -p /frp \
    && tar -xzf /frp.tar.gz -C /frp --strip-components=1 \
    && rm -f /frp.tar.gz

WORKDIR /

LABEL maintainer="sakura"

ADD 404.html /frp/404.html
ADD frps.toml /frp/frps.toml
ADD frpc.toml /frp/frpc.toml

VOLUME /frp

CMD /frp/$FRP -c /frp/$FRP.toml
