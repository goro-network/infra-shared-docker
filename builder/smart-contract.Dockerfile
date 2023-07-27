ARG CPU_ARCH

FROM ghcr.io/goro-network/goro-builder-node18-ubuntu2204:${CPU_ARCH}

RUN rustup default nightly-2023-03-25
RUN cargo install --locked \
    cargo-contract@3.0.1 \
    cargo-dylint@2.1.7 \
    dylint-link@2.1.7 \
    subxt-cli@0.30.0 \
    wasm-pack@0.12.1
