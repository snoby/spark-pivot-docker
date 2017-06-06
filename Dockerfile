FROM alpine:3.6
MAINTAINER Matt Snoby <matt.snoby@icloud.com>

ENV         GOPATH /go
ENV         SRCPATH ${GOPATH}/src/github.com/snoby
ENV         WEBHOOK_VERSION 2.6.4

RUN         apk add --update -t build-deps curl go git libc-dev gcc libgcc bash  && \
            git config --global http.https://gopkg.in.followRedirects true && \
            curl -L -o /tmp/webhook-${WEBHOOK_VERSION}.tar.gz https://github.com/adnanh/webhook/archive/${WEBHOOK_VERSION}.tar.gz && \
            mkdir -p ${SRCPATH} && tar -xvzf /tmp/webhook-${WEBHOOK_VERSION}.tar.gz -C ${SRCPATH} && \
            mv -f ${SRCPATH}/webhook-* ${SRCPATH}/webhook && \
            cd ${SRCPATH}/webhook && go get -d && go build -o /usr/local/bin/webhook

RUN         git clone https://github.com/snoby/spark-pivot.git ${SRCPATH}/spark-pivot  && \
            cd ${SRCPATH}/spark-pivot && go get -d && \
            go build -o /usr/local/bin/spark-pivot





RUN          apk del --purge build-deps && \
            rm -rf /var/cache/apk/* && \
            rm -rf ${GOPATH}

EXPOSE      9000

COPY hooks.json /etc/webhook/hooks.json

VOLUME "/etc/webhook/"

ENTRYPOINT  ["/usr/local/bin/webhook"]
CMD ["-verbose", "-hooks=/etc/webhook/hooks.json", "-hotreload"]
