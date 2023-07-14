MAKEFLAGS			+=	--jobs 1 --silent
SHELL				:=	/bin/bash
CPU_ARCH			:=	$(shell if [[ "$(shell uname -p)" = "x86_64" ]]; then echo amd64; else echo arm64; fi)

.PHONY: all builder-rust-llvm15
.ONESHELL: all builder-rust-llvm15

all: | builder-android28-ubuntu2204

builder-rust-llvm15:
	CURRENT_RECIPE="$(strip $(subst builder-,,$@))"
	echo -e "\033[92m\nBuilding Docker Image - \033[35m$${CURRENT_RECIPE}\n\033[0m"
	docker build \
		-t ghcr.io/goro-network/goro-builder-rust-llvm15:${CPU_ARCH} \
		-f builder/rust-llvm15.Dockerfile \
		.

builder-node18-ubuntu2204: | builder-rust-llvm15
	CURRENT_RECIPE="$(strip $(subst builder-,,$@))"
	echo -e "\033[92m\nBuilding Docker Image - \033[35m$${CURRENT_RECIPE}\n\033[0m"
	docker build \
		--build-arg CPU_ARCH=${CPU_ARCH} \
		-t ghcr.io/goro-network/goro-builder-node18-ubuntu2204:${CPU_ARCH} \
		-f builder/node18-ubuntu2204.Dockerfile \
		.

builder-android28-ubuntu2204: | builder-node18-ubuntu2204
	if [ ${CPU_ARCH} != amd64 ]; then\
		echo -e "\033[31m\nSupported Android Build System CPU is \"x86_64\"\n\033[0m" &&\
		exit 66; \
	fi
	CURRENT_RECIPE="$(strip $(subst builder-,,$@))"
	echo -e "\033[92m\nBuilding Docker Image - \033[35m$${CURRENT_RECIPE}\n\033[0m"
	docker build \
		-t ghcr.io/goro-network/goro-builder-android28-ubuntu2204:amd64 \
		-f builder/android28-ubuntu2204.Dockerfile \
		.
