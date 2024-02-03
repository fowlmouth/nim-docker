NIM_VERSION ?= 2.0.0
TAG_VERSION ?= $(NIM_VERSION)

ALL: push
.PHONY: push

push:
	docker buildx build \
		--tag docker.io/fowlmouth/nim:"$(TAG_VERSION)"-bookworm \
		--build-arg NIM_VERSION \
		--file debian.Dockerfile \
		--platform linux/arm64,linux/amd64,linux/ppc64le,linux/arm/v7,linux/arm/v5,linux/mips64le \
		--push \
		.
