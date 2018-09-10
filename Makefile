.PHONY: help init clean validate mock
.DEFAULT_GOAL := validate

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

init: ## init python
	@pipenv install --python 2.7.15

clean: ## clean
	@pipenv --rm

validate: ## validate swagger
	@pipenv run openapi-spec-validator --schema 2.0 swagger/swagger.yaml

mock: ## run the mock server
	@pipenv run connexion run swagger/swagger.yaml --mock=all -v --port=8080
