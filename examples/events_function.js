module.exports.handler = function(event, context, callback) {
    var event = JSON.parse(event);
    var content = {
        path: event.path,
        method: event.method,
        headers: event.headers,
        queryParameters: event.queryParameters,
        pathParameters: event.pathParameters,
        body: event.body
        // you can deal with your own logic here.
    }
    var response = {
        isBase64Encoded: false,
        statusCode: '200',
        headers: {
            'x-custom-header': 'header value'
        },
        body: content
    };
    callback(null, response)
};