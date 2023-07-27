# Builder Images

These images will be used for `build stage` in `multi-stage` docker build, the base images for `production stage` are located in [base](../base/README.md).

## Image Dependencies

1. [Android API 28/NDK 25c](./android28-ubuntu2204.Dockerfile) -> [NodeJS LTS 18/Yarn Classic](./node18-ubuntu2204.Dockerfile)
2. [NodeJS LTS 18/Yarn Classic](./node18-ubuntu2204.Dockerfile) -> [Rust nightly-2023-03-25/1.69.0/LLVM 15](./rust-llvm15.Dockerfile)
3. [Rust nightly-2023-03-25/1.69.0/LLVM 15](./rust-llvm15.Dockerfile) -> [Ubuntu LTS 22.04](https://hub.docker.com/layers/library/ubuntu/22.04/images/sha256-b060fffe8e1561c9c3e6dea6db487b900100fc26830b9ea2ec966c151ab4c020)
4. [Smart Contract](./smart-contract.Dockerfile) -> [NodeJS LTS 18/Yarn Classic](./node18-ubuntu2204.Dockerfile)

## Image Tags

`CPU_ARCH` can be `amd64` for `x86_64` or `arm64` for `aarch64`.

### Android API 28/NDK 25c

**NOTE:** _amd64 only_

```text
ghcr.io/goro-network/goro-builder-android28-ubuntu2204:${CPU_ARCH}
```

### NodeJS LTS 18/Yarn Classic

```text
ghcr.io/goro-network/goro-builder-node18-ubuntu2204:amd64
```

### Rust nightly-2023-03-25/1.69.0/LLVM 15

```text
ghcr.io/goro-network/goro-builder-rust-llvm15:${CPU_ARCH}
```

## Smart Contract

```text
ghcr.io/goro-network/goro-builder-smart-contract:${CPU_ARCH}
```
