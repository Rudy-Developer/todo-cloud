.PHONY: build-layer deploy-dev deploy-qa deploy-prod

LAYER_DIR=./layer/python/common
COMMON_DIR=./src/common

build:
	$(MAKE) clean
	mkdir -p $(LAYER_DIR)
	cp -r $(COMMON_DIR)/* $(LAYER_DIR)/
	echo "update content of 'common'"

delete-stack:
ifndef ENV
	$(error Debes especificar el ambiente con ENV=dev, ENV=qa o ENV=prod)
endif
	@echo "Verificando si existe el stack: todo-api-$(ENV)..."
	@if aws cloudformation describe-stacks --stack-name todo-api-$(ENV) 2>/dev/null; then \
		echo "Stack existe. Eliminando..."; \
		aws cloudformation delete-stack --stack-name todo-api-$(ENV); \
		aws cloudformation wait stack-delete-complete --stack-name todo-api-$(ENV); \
		echo "Stack todo-api-$(ENV) eliminado correctamente."; \
	else \
		echo "Stack todo-api-$(ENV) no existe. Continuando..."; \
	fi

deploy-dev: 
	$(MAKE) build
	$(MAKE) delete-stack ENV=dev
	sam build
	sam deploy --config-env dev

deploy-qa: build-layer
	sam deploy --config-env qa

deploy-prod: build-layer
	sam deploy --config-env prod

run:
	sam build
	sam local start-api --config-env local

clean:
	rm -rf .aws-sam
	rm -rf  ./layer
	echo "Proyecto limpio"


undeploy-dev:
	aws cloudformation delete-stack --stack-name todo-api-dev --region us-east-2
