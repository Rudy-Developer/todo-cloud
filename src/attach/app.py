import json
import os
from common.utils import log_event  # desde el layer

def lambda_handler(event, context):
    log_event(event)

    action = event.get("action", "none")
    file = event.get("file", "no-file")

    # Simulación de trabajo con S3
    if action == "upload":
        result = f"File {file} uploaded to S3 in {os.environ['STAGE']}"

    elif action == "delete":
        result = f"File {file} deleted from S3 in {os.environ['STAGE']}"

    else:
        result = "Unknown action"

    return {
        "statusCode": 200,
        "body": json.dumps({
            "status": "ok",
            "result": result
        }),
    }
