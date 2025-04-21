#!/bin/bash

set -e

STACK_NAME="todo-stack"
REGION="us-east-2"

echo "🧨 Eliminando stack: $STACK_NAME"
aws cloudformation delete-stack --stack-name $STACK_NAME --region $REGION

echo "⏳ Esperando a que el stack se elimine completamente..."
aws cloudformation wait stack-delete-complete --stack-name $STACK_NAME --region $REGION

echo "✅ Stack eliminado exitosamente"

echo "🛠️ Construyendo SAM"
sam build

echo "🚀 Desplegando nuevamente con SAM"
sam deploy --config-env default --no-confirm-changeset --no-fail-on-empty-changeset --resolve-s3

echo "🎉 Despliegue exitoso"
