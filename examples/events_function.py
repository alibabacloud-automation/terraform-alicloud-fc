# -*- coding: utf-8 -*-
import json
def handler(event, context):
    event = json.loads(event)
    content = {
        'path': event['path'],
        'method': event['httpMethod'],
        'headers': event['headers'],
        'queryParameters': event['queryParameters'],
        'pathParameters': event['pathParameters'],
        'body': event['body']
    }
    # you can deal with your own logic here. 
    rep = {
        "isBase64Encoded": "false",
        "statusCode": "200",
        "headers": {
            "x-custom-header": "no"
        },
        "body": content
    }
    return json.dumps(rep)