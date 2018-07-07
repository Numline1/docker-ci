IMAGE=hrcc/docker-ci:latest

.DEFAULT_GOAL := help

shell: ## Enters the shell
	docker run -it $(IMAGE) bash

build: ## Build the docker image
	docker build -t $(IMAGE) .
	docker history $(IMAGE) > build_log.txt

tests: ## Run the unit tests
	GOSS_FILES_PATH=./test dgoss run -t $(IMAGE)

help: ## Display this help message
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.SILENT: build test help
