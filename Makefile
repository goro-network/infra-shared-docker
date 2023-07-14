MAKEFLAGS			+=	--jobs 1 --silent
SHELL				:=	/bin/bash
CPU_ARCH			:=	$(shell if [[ "$(shell uname -p)" = "x86_64" ]]; then echo amd64; else echo arm64; fi)
TARGETS				:=	rust-llvm15 node18-ubuntu2204 android28-ubuntu2204
BUILDER_TARGETS			:=	$(addprefix builder-,$(TARGETS))
BUILDER_IMAGE_PREFIX		:=	ghcr.io/goro-network/goro-builder-
PUSH_BUILDER_TARGETS		:=	$(addprefix push-builder-,$(TARGETS))

.PHONY: all builder push-builder $(BUILDER_TARGETS) $(PUSH_BUILDER_TARGETS)
.ONESHELL: all builder push-builder $(BUILDER_TARGETS) $(PUSH_BUILDER_TARGETS)

all: | push-builder

builder: | $(BUILDER_TARGETS)

push-builder: | $(PUSH_BUILDER_TARGETS)

$(BUILDER_TARGETS):
	CURRENT_RECIPE="$(strip $(subst builder-,,$@))"
	echo -e "\033[92m\nBuilding Docker Image - \033[35m$${CURRENT_RECIPE}\n\033[0m"
	docker build \
		--build-arg CPU_ARCH=${CPU_ARCH} \
		-t ${BUILDER_IMAGE_PREFIX}$${CURRENT_RECIPE}:${CPU_ARCH} \
		-f builder/$${CURRENT_RECIPE}.Dockerfile \
		.

$(PUSH_BUILDER_TARGETS):
	CURRENT_RECIPE="$(strip $(subst push-builder-,,$@))"
	BUILDER_RECIPE="$(addprefix builder-,$${CURRENT_RECIPE})"
	$(MAKE) $${BUILDER_RECIPE}
	docker push ${BUILDER_IMAGE_PREFIX}$${CURRENT_RECIPE}:${CPU_ARCH}
