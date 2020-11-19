# aws-sam-cli

## Reference
- [Jump-starting your serverless development environment](https://aws.amazon.com/blogs/compute/jump-starting-your-serverless-development-environment/)

## Introduction

[AWS Serverless Application Model (AWS SAM)](https://aws.amazon.com/serverless/sam/) is an extension for CloudFormation that further simplifies the process of building serverless application resources.

It provides shorthand syntax to define Lambda functions, APIs, databases, and event source mappings. During deployment, the AWS SAM syntax is transformed into AWS CloudFormation syntax, enabling you to build serverless applications faster.

The [AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-reference.html#serverless-sam-cli) is an open source command line tool used to locally build, test, debug, and deploy serverless applications defined with AWS SAM templates.

## Install

```bash
brew tap aws/tap
brew install aws-sam-cli
sam --version
```

## Getting Started

```bash
sam init --help
sam init --name hello-sam --runtime nodejs10.x --dependency-manager npm --app-template hello-world
cd hello-sam
sam build
sam local invoke "HelloWorldFunction" -e events/event.json
sam local start-api
curl http://localhost:3000/ # Did not work for me as the authorization was not set. Hmm..
sam deploy -g
# At the end of sam deploy -g, you should see output of the API Gateway URL. You can find it from CloudFormation Output section as well
curl -s https://fc58gssteb.execute-api.us-east-1.amazonaws.com/Prod/hello/ | jq .
sam logs -n HelloWorldFunction --stack-name hello-sam --tail
```