# GitHub CI/CD para AWS con SAM

Este proyecto demuestra cómo configurar una solución completa CI/CD usando **GitHub Actions** y **AWS SAM** para desplegar Lambdas, API Gateway, DynamoDB y S3 en múltiples ambientes.

---

## 📁 Estructura del Proyecto

```
my-todo-app/
├── template.yaml                # Plantilla SAM con funciones Lambda y API Gateway
├── samconfig.toml              # Configuración de SAM por ambiente
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions para despliegue continuo
├── scripts/
│   ├── create_roles.sh         # Script para crear roles IAM
│   ├── trust-policy.json
│   ├── task-lambda-policy.json
│   ├── github-trust-policy.json
│   └── github-actions-policy.json
└── tasks/ y attachments/       # Código fuente de Lambdas
```

---

## 🔐 Configuración de Roles IAM

### 1. Rol Lambda

```bash
aws iam create-role \
  --role-name task-lambda-role-dev \
  --assume-role-policy-document file://trust-policy.json

aws iam put-role-policy \
  --role-name task-lambda-role-dev \
  --policy-name task-lambda-policy \
  --policy-document file://task-lambda-policy.json
```

### 2. Rol GitHub Actions con OIDC

```bash
aws iam create-role \
  --role-name github-actions-role \
  --assume-role-policy-document file://github-trust-policy.json

aws iam put-role-policy \
  --role-name github-actions-role \
  --policy-name github-actions-policy \
  --policy-document file://github-actions-policy.json
```

📌 **Reemplaza** `<ACCOUNT_ID>`, `<OWNER>` y `<REPO>` en los archivos de política.

---

## 🚀 Despliegue Automático

Cada vez que se hace `push` a la rama `main`, GitHub ejecutará:

- Checkout del código
- Asume el rol `github-actions-role`
- Ejecuta `sam build` y `sam deploy`

---

## 🛠️ Personalización

Cambia el valor `Environment=dev` en `samconfig.toml` y el nombre del `stack_name` para `staging` o `production`.

---

## 🧪 Pruebas Locales

```bash
sam build
sam local invoke TaskFunction --event event.json
```

---

## 📌 Requisitos Previos

- AWS CLI y SAM CLI instalados
- Repositorio en GitHub conectado a AWS OIDC (ver configuración de `github-actions-role`)
