# Import API specifics
use "awscc_base"

resource_name :aws_lambda_permission
provides :aws_lambda_permission, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Lambda::Permission
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :action, String,
         required: true,
         callbacks: {
           "action is not a String" => lambda { |v| v.is_a? String },
           "action needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "action must match pattern ^(lambda:[*]|lambda:[a-zA-Z]+|[*])$" => lambda { |v| v =~ Regexp.new("/^(lambda:[*]|lambda:[a-zA-Z]+|[*])$/") },
         },
         description: <<~'DESCRIPTION'
           The action that the principal can use on the function.
         DESCRIPTION

property :event_source_token, String,
         callbacks: {
           "event_source_token is not a String" => lambda { |v| v.is_a? String },
           "event_source_token needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "event_source_token must match pattern ^[a-zA-Z0-9._\-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9._\-]+$/") },
         },
         description: <<~'DESCRIPTION'
           For Alexa Smart Home functions, a token that must be supplied by the invoker.
         DESCRIPTION

property :function_name, String,
         required: true,
         callbacks: {
           "function_name is not a String" => lambda { |v| v.is_a? String },
           "function_name needs to be 1..140 characters" => lambda { |v| v.length >= 1 && v.length <= 140 },
           "function_name must match pattern ^(arn:(aws[a-zA-Z-]*)?:lambda:)?([a-z]{2}(-gov)?-[a-z]+-\d{1}:)?(\d{12}:)?(function:)?([a-zA-Z0-9-_]+)(:(\$LATEST|[a-zA-Z0-9-_]+))?$" => lambda { |v| v =~ Regexp.new("/^(arn:(aws[a-zA-Z-]*)?:lambda:)?([a-z]{2}(-gov)?-[a-z]+-\d{1}:)?(\d{12}:)?(function:)?([a-zA-Z0-9-_]+)(:(\$LATEST|[a-zA-Z0-9-_]+))?$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the Lambda function, version, or alias.
         DESCRIPTION

property :function_url_auth_type, String,
         callbacks: {
           "function_url_auth_type is not a String" => lambda { |v| v.is_a? String },
           "function_url_auth_typeis not one of `AWS_IAM`, `NONE`" => lambda { |v| %w{AWS_IAM NONE}.include? v },
         },
         description: <<~'DESCRIPTION'
           The type of authentication that your function URL uses. Set to AWS_IAM if you want to restrict access to authenticated users only. Set to NONE if you want to bypass IAM authentication to create a public endpoint.
         DESCRIPTION

property :principal, String,
         required: true,
         callbacks: {
           "principal is not a String" => lambda { |v| v.is_a? String },
           "principal needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "principal must match pattern ^.*$" => lambda { |v| v =~ Regexp.new("/^.*$/") },
         },
         description: <<~'DESCRIPTION'
           The AWS service or account that invokes the function. If you specify a service, use SourceArn or SourceAccount to limit who can invoke the function through that service.
         DESCRIPTION

property :principal_org_id, String,
         callbacks: {
           "principal_org_id is not a String" => lambda { |v| v.is_a? String },
           "principal_org_id needs to be 12..34 characters" => lambda { |v| v.length >= 12 && v.length <= 34 },
           "principal_org_id must match pattern ^o-[a-z0-9]{10,32}$" => lambda { |v| v =~ Regexp.new("/^o-[a-z0-9]{10,32}$/") },
         },
         description: <<~'DESCRIPTION'
           The identifier for your organization in AWS Organizations. Use this to grant permissions to all the AWS accounts under this organization.
         DESCRIPTION

property :source_account, String,
         callbacks: {
           "source_account is not a String" => lambda { |v| v.is_a? String },
           "source_account needs to be 12..12 characters" => lambda { |v| v.length >= 12 && v.length <= 12 },
           "source_account must match pattern ^\d{12}$" => lambda { |v| v =~ Regexp.new("/^\d{12}$/") },
         },
         description: <<~'DESCRIPTION'
           For Amazon S3, the ID of the account that owns the resource. Use this together with SourceArn to ensure that the resource is owned by the specified account. It is possible for an Amazon S3 bucket to be deleted by its owner and recreated by another account.
         DESCRIPTION

property :source_arn, String,
         callbacks: {
           "source_arn is not a String" => lambda { |v| v.is_a? String },
           "source_arn needs to be 12..1024 characters" => lambda { |v| v.length >= 12 && v.length <= 1024 },
           "source_arn must match pattern ^arn:(aws[a-zA-Z0-9-]*):([a-zA-Z0-9\-])+:([a-z]{2}(-gov)?-[a-z]+-\d{1})?:(\d{12})?:(.*)$" => lambda { |v| v =~ Regexp.new("/^arn:(aws[a-zA-Z0-9-]*):([a-zA-Z0-9\-])+:([a-z]{2}(-gov)?-[a-z]+-\d{1})?:(\d{12})?:(.*)$/") },
         },
         description: <<~'DESCRIPTION'
           For AWS services, the ARN of the AWS resource that invokes the function. For example, an Amazon S3 bucket or Amazon SNS topic.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Lambda::Permission"
rest_api_document "/AWS::Lambda::Permission"

rest_property_map({
  action:                 "Action",
  event_source_token:     "EventSourceToken",
  function_name:          "FunctionName",
  function_url_auth_type: "FunctionUrlAuthType",
  principal:              "Principal",
  principal_org_id:       "PrincipalOrgID",
  source_account:         "SourceAccount",
  source_arn:             "SourceArn",
})

rest_post_only_properties %i{
  action event_source_token function_name function_url_auth_type principal principal_org_id source_account source_arn
}
