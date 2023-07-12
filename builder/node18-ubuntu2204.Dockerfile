ARG CPU_ARCH

FROM ghcr.io/goro-network/goro-builder-rust-llvm15:${CPU_ARCH}

## NodeJS LTS 18 & NPM
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash && \
    apt-get update && \
    apt-get install -y nodejs && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## Yarn Classic
RUN npm install --global yarn

RUN node --version && \
    yarn --version
