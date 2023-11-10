NIM_VERSION ?= 2.0.0

ALL: push
.PHONY: push

push:
	docker buildx build \
		--tag docker.io/fowlmouth/nim:"$(NIM_VERSION)"-bookworm \
		--file debian.Dockerfile \
		--platform linux/arm64,linux/amd64,linux/ppc64le,linux/arm/v7,linux/arm/v5,linux/mips64le \
		--push \
		.
