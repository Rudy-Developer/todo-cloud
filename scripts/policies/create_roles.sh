#create role for lambda function
aws iam create-role \
  --role-name task-lambda-role-dev \
  --assume-role-policy-document file://trust-policy.json

#create policy for lambda function
aws iam create-policy \
  --policy-name task-lambda-policy-dev \
  --policy-document file://task-lambda-policy-dev.json

# Attach the policy to the role
aws iam attach-role-policy \
  --role-name task-lambda-role-dev \
  --policy-arn arn:aws:iam::413600747077:policy/task-lambda-policy-dev
###################Attach the policy to the role######################

#create role for lambda function
aws iam create-role \
  --role-name attach-lambda-role-dev \
  --assume-role-policy-document file://trust-policy.json

#create policy for lambda function
aws iam create-policy \
  --policy-name attach-lambda-policy-dev \
  --policy-document file://attach-lambda-policy-dev.json
  
# Attach the policy to the role
aws iam attach-role-policy \
  --role-name attach-lambda-role-dev \
  --policy-arn arn:aws:iam::413600747077:policy/attach-lambda-policy-dev