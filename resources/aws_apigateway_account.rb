# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_apigateway_account
provides :aws_apigateway_account, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGateway::Account
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :cloudwatch_role_arn, String,
         callbacks: {
           "cloudwatch_role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of an IAM role that has write access to CloudWatch Logs in your account.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApiGateway::Account"
rest_api_document "/AWS::ApiGateway::Account"

rest_property_map({
  cloudwatch_role_arn: "CloudWatchRoleArn",
})

