exports.lambda_Handler = async (event, context) => {
    context.succeed(process.env.greeting + ' ' + event.name);
 };