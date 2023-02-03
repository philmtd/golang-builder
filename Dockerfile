FROM golang:1.20-alpine

ENV GOTESTUM_VERSION "1.9.0"
ENV GOLANGCI_LINT_VERSION "1.51.0"

RUN apk add --no-cache bash make upx build-base git openssh ca-certificates && update-ca-certificates

RUN wget "https://github.com/gotestyourself/gotestsum/releases/download/v${GOTESTUM_VERSION}/gotestsum_${GOTESTUM_VERSION}_linux_amd64.tar.gz" \
    && tar -xvzf "gotestsum_${GOTESTUM_VERSION}_linux_amd64.tar.gz" \
    && mv gotestsum /bin \
    && chmod +x /bin/gotestsum \
    && rm -rf *.tar.gz

RUN wget -O- -nv https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s "v${GOLANGCI_LINT_VERSION}"
