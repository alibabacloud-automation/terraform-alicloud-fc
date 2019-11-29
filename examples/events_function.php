<?php
function handler($event, $context) {
    $event   = json_decode($event, $assoc = true);
    $content = [
        'path'            => $event['path'],
        'method'          => $event['httpMethod'],
        'headers'         => $event['headers'],
        'queryParameters' => $event['queryParameters'],
        'pathParameters'  => $event['pathParameters'],
        'body'            => $event['body'],
    ];
    $rep = [
        "isBase64Encoded" => "false",
        "statusCode"      => "200",
        "headers"         => [
            "x-custom-header" => "no",
        ],
        "body"            => $content,
    ];
    return json_encode($rep);
}