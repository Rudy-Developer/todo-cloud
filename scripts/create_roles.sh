#!/bin/bash

aws iam create-role \
  --role-name task-lambda-role-dev \
  --assume-role-policy-document file://trust-policy.json

aws iam put-role-policy \
  --role-name task-lambda-role-dev \
  --policy-name task-lambda-policy \
  --policy-document file://task-lambda-policy.json

# 2. Rol GitHub Actions con OIDC


aws iam create-role \
  --role-name github-actions-role \
  --assume-role-policy-document file://github-trust-policy.json

aws iam put-role-policy \
  --role-name github-actions-role \
  --policy-name github-actions-policy \
  --policy-document file://github-actions-policy.json

  aws iam create-open-id-connect-provider \
  --url https://token.actions.githubusercontent.com \
  --client-id-list sts.amazonaws.com \
  --thumbprint-list d89e3bd43d5d909b47a18977aa9d5ce36cee184c