# Variables
STACK_NAME=todo-stack
REGION=us-east-2
S3_BUCKET=todo-cloud-demo
PROFILE=default
TEMPLATE=template.yaml
BUILD_DIR=.aws-sam/build
DEPLOY_TEMPLATE=$(BUILD_DIR)/template.yaml

# Objetivo predeterminado
all: build validate deploy

# Construir la aplicación
build:
	sam build --template $(TEMPLATE)

# Probar localmente con API Gateway
start-api:
	sam local start-api --template $(DEPLOY_TEMPLATE)

# Invocar la función localmente con un evento
invoke:
	sam local invoke TaskFunction --event events/event.json --template $(DEPLOY_TEMPLATE)

# Validar la plantilla SAM
validate:
	sam validate --template $(TEMPLATE)

# Desplegar la aplicación
deploy:
	sam deploy \
		--template-file $(DEPLOY_TEMPLATE) \
		--stack-name $(STACK_NAME) \
		--s3-bucket $(S3_BUCKET) \
		--capabilities CAPABILITY_IAM \
		--region $(REGION) \
		--profile $(PROFILE)
# Eliminar la pila de CloudFormation
undeploy:
	SAM_CLI_TELEMETRY=0 sam delete \
		--stack-name $(STACK_NAME) \
		--region $(REGION) \
		--profile $(PROFILE) \
		--no-prompts
		
# Limpiar los artefactos de construcción
clean:
	rm -rf $(BUILD_DIR)

# Ayuda
help:
	@echo "Comandos disponibles:"
	@echo "  build       - Construir la aplicación"
	@echo "  start-api   - Iniciar API Gateway localmente"
	@echo "  invoke      - Invocar la función localmente con un evento"
	@echo "  validate    - Validar la plantilla SAM"
	@echo "  deploy      - Desplegar la aplicación a AWS"
	@echo "  clean       - Limpiar los artefactos de construcción"
