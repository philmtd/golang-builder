FROM golang:1.17.6-alpine

RUN apk add --no-cache bash make upx build-base git openssh ca-certificates && update-ca-certificates

RUN wget https://github.com/gotestyourself/gotestsum/releases/download/v1.7.0/gotestsum_1.7.0_linux_amd64.tar.gz \
    && tar -xvzf gotestsum_1.7.0_linux_amd64.tar.gz \
    && mv gotestsum /bin \
    && chmod +x /bin/gotestsum \
    && rm -rf *.tar.gz

RUN wget -O- -nv https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s v1.44.0
