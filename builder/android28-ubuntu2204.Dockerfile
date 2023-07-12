FROM ghcr.io/goro-network/goro-builder-node18-ubuntu2204:amd64

ARG BUILDTOOLS_VERSION="33.0.2"
ARG GRADLE_VERSION="8.2.1"
ARG JDK_VERSION="11"
ARG NDK_VERSION="25.2.9519653"
ARG SDKMANAGER_VERSION="9477386_latest"

ENV ANDROID_HOME="/opt/android"
ENV GRADLE_FILE="gradle-${GRADLE_VERSION}-bin.zip"
ENV GRADLE_HOME="/opt/gradle"
ENV GRADLE_PATH="${GRADLE_HOME}/gradle-${GRADLE_VERSION}/bin"
ENV NDK_PATH="${ANDROID_HOME}/ndk/${NDK_VERSION}/toolchains/llvm/prebuilt/linux-x86_64/bin"
ENV SDKMANAGER_DIR="${ANDROID_HOME}/cmdline-tools"
ENV SDKMANAGER_FILE="commandlinetools-linux-${SDKMANAGER_VERSION}.zip"
ENV SDKMANAGER_PATH="${SDKMANAGER_DIR}/latest/bin"
ENV PATH="${NDK_PATH}:${GRADLE_PATH}:${SDKMANAGER_PATH}:${PATH}"

## OpenJDK
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    openjdk-11-jdk-headless && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## Gradle
RUN mkdir -p ${GRADLE_HOME} && \
    cd ${GRADLE_HOME} && \
    wget -q "https://services.gradle.org/distributions/${GRADLE_FILE}" && \
    unzip "${GRADLE_FILE}" && \
    rm "${GRADLE_FILE}"

## SDK Manager
RUN mkdir -p ${SDKMANAGER_DIR} && \
    cd ${SDKMANAGER_DIR} && \
    wget "https://dl.google.com/android/repository/${SDKMANAGER_FILE}" && \
    unzip "${SDKMANAGER_FILE}" && \
    mv cmdline-tools latest && \
    rm "${SDKMANAGER_FILE}"

## SDK 28-33 Install
RUN i=28 && \
    while [ ${i} -ne 34 ]; \
    do \
        yes | sdkmanager "platforms;android-${i}"; \
        i=$(($i+1)); \
    done

## NDK & Build Tools Install
RUN sdkmanager "ndk;${NDK_VERSION}" && \
    sdkmanager "build-tools;${BUILDTOOLS_VERSION}"

## Version Check
RUN sdkmanager --version && \
    gradle --version && \
    java --version

LABEL org.opencontainers.image.authors "goro Developers <dev@goro.network>"
LABEL org.opencontainers.image.source "https://github.com/goro-network/infra-shared-docker"
LABEL org.opencontainers.image.description "Android builder image for x86_64"
