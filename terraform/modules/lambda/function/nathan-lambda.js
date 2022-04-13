exports.lambda_Handler = async (event, context) => {
     const response = {
        "statusCode": 200,
        "body": JSON.stringify(process.env.greeting + ' Nathan'),
        "isBase64Encoded": false
    };

    context.succeed(response);
};