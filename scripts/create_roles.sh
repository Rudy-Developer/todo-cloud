#!/bin/bash

aws iam create-role \
  --role-name task-lambda-role-dev \
  --assume-role-policy-document file://trust-policy.json

aws iam put-role-policy \
  --role-name task-lambda-role-dev \
  --policy-name task-lambda-policy \
  --policy-document file://task-lambda-policy.json
