aws dynamodb create-table \
  --table-name task-table-dev \
  --attribute-definitions \
      AttributeName=task_id,AttributeType=S \
      AttributeName=user_id,AttributeType=S \
  --key-schema \
      AttributeName=task_id,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --global-secondary-indexes \
      '[
        {
          "IndexName": "user_id-index",
          "KeySchema": [
            {"AttributeName": "user_id", "KeyType": "HASH"}
          ],
          "Projection": {
            "ProjectionType": "ALL"
          }
        }
      ]' \
  --region us-east-2