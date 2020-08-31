PWD ?= pwd_unknown
PROJECT_NAME = $(notdir $(PWD))

.PHONY: help build-dev build-prod 
help:
	@echo ''
	@echo 'Usage: make [TARGET]'
	@echo 'Targets:'
	@echo '  build-dev    	build docker --image-- for current development'
	@echo '  build-prod  	rebuild docker --image-- for prodution and push to registry'
	

build-dev:
	docker build -t folan -f Dockerfile.devel .

build-prod:
	docker build -t ${CI_PROJECT_NAME}:${CI_COMMIT_TAG} -f Dockerfile .

clean-pyc:
    find . -name '*.pyc' -exec rm --force {} +
    find . -name '*.pyo' -exec rm --force {} +
   name '*~' -exec rm --force  {}

