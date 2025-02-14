CURRENT_WORKING_DIR=$(shell pwd)

GOOS          ?= $(if $(TARGETOS),$(TARGETOS),linux)
GOARCH        ?= $(if $(TARGETARCH),$(TARGETARCH),amd64)
BUILDPLATFORM ?= $(GOOS)/$(GOARCH)

MKDOCS_IMAGE := squidfunk/mkdocs-material:9.6

initialise:
	@echo "Initialising pre-commit hooks"
	pre-commit --version || brew install pre-commit
	pre-commit install --install-hooks
	pre-commit run -a

run:
	@echo "Running the application"
	docker run --rm --platform $(BUILDPLATFORM) -it -p 8000:8000 -v `pwd`:/docs $(MKDOCS_IMAGE)
