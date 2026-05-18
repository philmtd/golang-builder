FROM golang:1.26.3-alpine

ENV GOTESTUM_VERSION="1.13.0"
ENV GOLANGCI_LINT_VERSION="2.12.2"
ENV MAGE_VERSION="1.17.2"

RUN apk add --no-cache bash upx build-base git openssh tar ca-certificates && update-ca-certificates

RUN set -eux; \
    arch="$(apk --print-arch)"; \
    case "$arch" in \
        x86_64)  GOTESTSUM_ARCH="amd64"; MAGE_ARCH="64bit" ;; \
        aarch64) GOTESTSUM_ARCH="arm64"; MAGE_ARCH="ARM64" ;; \
        *) echo "unsupported arch: $arch" >&2; exit 1 ;; \
    esac; \
    wget "https://github.com/gotestyourself/gotestsum/releases/download/v${GOTESTUM_VERSION}/gotestsum_${GOTESTUM_VERSION}_linux_${GOTESTSUM_ARCH}.tar.gz" \
    && tar -xvzf "gotestsum_${GOTESTUM_VERSION}_linux_${GOTESTSUM_ARCH}.tar.gz" \
    && mv gotestsum /bin \
    && chmod +x /bin/gotestsum \
    && rm -rf *.tar.gz; \
    wget "https://github.com/magefile/mage/releases/download/v${MAGE_VERSION}/mage_${MAGE_VERSION}_Linux-${MAGE_ARCH}.tar.gz" \
    && tar -xvzf "mage_${MAGE_VERSION}_Linux-${MAGE_ARCH}.tar.gz" \
    && mv mage /bin \
    && chmod +x /bin/mage \
    && rm -rf *.tar.gz

RUN wget -O- -nv https://golangci-lint.run/install.sh | sh -s "v${GOLANGCI_LINT_VERSION}"
