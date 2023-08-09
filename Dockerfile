FROM golang:1.21.0-alpine

ENV GOTESTUM_VERSION "1.10.1"
ENV GOLANGCI_LINT_VERSION "1.54.1"
ENV MAGE_VERSION "1.15.0"

RUN apk add --no-cache bash upx build-base git openssh ca-certificates && update-ca-certificates

RUN wget "https://github.com/gotestyourself/gotestsum/releases/download/v${GOTESTUM_VERSION}/gotestsum_${GOTESTUM_VERSION}_linux_amd64.tar.gz" \
    && tar -xvzf "gotestsum_${GOTESTUM_VERSION}_linux_amd64.tar.gz" \
    && mv gotestsum /bin \
    && chmod +x /bin/gotestsum \
    && rm -rf *.tar.gz

RUN wget -O- -nv https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s "v${GOLANGCI_LINT_VERSION}"

RUN wget "https://github.com/magefile/mage/releases/download/v${MAGE_VERSION}/mage_${MAGE_VERSION}_Linux-64bit.tar.gz" \
    && tar -xvzf "mage_${MAGE_VERSION}_Linux-64bit.tar.gz" \
    && mv mage /bin \
    && chmod +x /bin/mage \
    && rm -rf *.tar.gz
