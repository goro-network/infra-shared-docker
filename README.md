# Docker Images for `goro` Network Ecosystem

Common/shared docker images for the entire `goro` Network ecosystem, mainly used for [Github's Action (CI/CD)](https://github.com/features/actions).

## Supported CPU Architecture

Either `x86_64 (amd64)` or `aarch64 (arm64)`, except for `Android builder (arm64 only)`.

## [Base Images](./base/README.md)

TBD

## [Builder Images](./builder/README.md)

### [Rust LLVM15]((./rust-llvm15.Dockerfile))

- Base Image    : `ubuntu:22.04`
- Image Name    : `ghcr.io/goro-network/goro-builder-rust-llvm15:[amd64 or arm64]`
- Nightly       : `nightly-2023-03-25`
- Stable        : `1.69.0`
- LLVM          : `15.0.7`

### [Node18 Ubuntu 22.04](./builder/node18-ubuntu2204.Dockerfile)

- Base Image    : `ghcr.io/goro-network/goro-builder-rust-llvm15:[amd64 or arm64]`
- Image Name    : `ghcr.io/goro-network/goro-builder-node18-ubuntu22.04:[amd64 or arm64]`
- NodeJS        : `LTS 18.16.1`
- Yarn          : `Classic 1.22.19`

### [Android28 Ubuntu 22.04](./builder/android28-ubuntu2204.Dockerfile)

- Base Image    : `ghcr.io/goro-network/goro-builder-node18-ubuntu22.04:amd64`
- Image Name    : `ghcr.io/goro-network/goro-builder-android28-ubuntu22.04:amd64`
- Android SDK   : `28 - 33`
- NDK           : `25.2.9519653 (25c)`
- Gradle        : `8.2.1`
