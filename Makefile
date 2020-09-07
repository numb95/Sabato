PWD ?= pwd_unknown


.PHONY: help build-dev build-prod clean-pyc clean-all lint test run doc
help:
	@echo ''
	@echo 'Usage: make [TARGET]'
	@echo 'Targets:'
	@echo '  build-dev		Build docker image for current development'
	@echo '  build-prod		Build docker image for prodution and push to registry'
	@echo '  clean-pyc		Delete all .pyc and .pyo files'
	@echo '  clean-all		Delete all .pyc, .pyo, .egg, .egg-info, __pycache__, dist/ and build/ '	
	@echo '  lint			Lint the code using flake8'
	@echo '  test			Run test'
	@echo '  run			Run the project on localserver'
	@echo '  doc			Generate docs'

build-dev:
	docker build -t folan -f Dockerfile.devel .

build-prod:
	docker build -t `echo ${${CI_PROJECT_NAME}^}`:${CI_COMMIT_TAG} -f Dockerfile .
	docker tag ${${CI_PROJECT_NAME}^}`:${CI_COMMIT_TAG} ${${CI_PROJECT_NAME}^}`:latest
	docker push ${${CI_PROJECT_NAME}^}`:${CI_COMMIT_TAG}
	docker push ${${CI_PROJECT_NAME}^}`:latest

clean-pyc:
	find . -name '*.pyc' -exec rm --force {} +
	find . -name '*.pyo' -exec rm --force {} +

clean-all:
	find . -name '*.pyc' -exec rm --force {} +
	find . -name '*.pyo' -exec rm --force {} +
	find . -name '*.egg-info' -exec rm -R --force {} +
	find . -name '*.egg*' -exec rm -R --force {} +
	find . -name '__pycache__' -exec rm -R --force {} +
	find . -name '.pytest_cache' -exec rm -R --force {} +
	rm --force --recursive build/
	rm --force --recursive dist/

lint:
	flake8 --exclude=.tox

test:
	py.test --verbose --color=yes $(TEST_PATH)

run:
	python manage.py runserver

doc:
	make -C docs/ html