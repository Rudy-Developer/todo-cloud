import json
import boto3
import os
from common.utils import log_event  # desde el layer

lambda_client = boto3.client('lambda')

def lambda_handler(event, context):
    log_event(event)
    
    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Task processed"
        }),
    }
