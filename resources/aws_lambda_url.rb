# Import API specifics
use "awscc_base"

resource_name :aws_lambda_url
provides :aws_lambda_url, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Lambda::Url
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :auth_type, String,
         required: true,
         callbacks: {
           "auth_type is not a String" => lambda { |v| v.is_a? String },
           "auth_typeis not one of `AWS_IAM`, `NONE`" => lambda { |v| %w{AWS_IAM NONE}.include? v },
         },
         description: <<~'DESCRIPTION'
           Can be either AWS_IAM if the requests are authorized via IAM, or NONE if no authorization is configured on the Function URL.
         DESCRIPTION

property :cors, Hash,
         callbacks: {
           "Subproperty `AllowCredentials` is not a Boolean" => lambda { |v| v[:AllowCredentials].is_a? Boolean },
           "Subproperty `MaxAge` is not a Integer" => lambda { |v| v[:MaxAge].is_a? Integer },
         },
         description: ""

property :invoke_mode, String,
         callbacks: {
           "invoke_mode is not a String" => lambda { |v| v.is_a? String },
           "invoke_modeis not one of `BUFFERED`, `RESPONSE_STREAM`" => lambda { |v| %w{BUFFERED RESPONSE_STREAM}.include? v },
         },
         description: <<~'DESCRIPTION'
           The invocation mode for the function?s URL. Set to BUFFERED if you want to buffer responses before returning them to the client. Set to RESPONSE_STREAM if you want to stream responses, allowing faster time to first byte and larger response payload sizes. If not set, defaults to BUFFERED.
         DESCRIPTION

property :qualifier, String,
         callbacks: {
           "qualifier is not a String" => lambda { |v| v.is_a? String },
           "qualifier needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "qualifier must match pattern ((?!^[0-9]+$)([a-zA-Z0-9-_]+))" => lambda { |v| v =~ Regexp.new("/((?!^[0-9]+$)([a-zA-Z0-9-_]+))/") },
         },
         description: <<~'DESCRIPTION'
           The alias qualifier for the target function. If TargetFunctionArn is unqualified then Qualifier must be passed.
         DESCRIPTION

property :target_function_arn, String,
         required: true,
         callbacks: {
           "target_function_arn is not a String" => lambda { |v| v.is_a? String },
           "target_function_arn must match pattern ^(arn:(aws[a-zA-Z-]*)?:lambda:)?([a-z]{2}((-gov)|(-iso(b?)))?-[a-z]+-\d{1}:)?(\d{12}:)?(function:)?([a-zA-Z0-9-_]+)(:((?!\d+)[0-9a-zA-Z_]+))?$" => lambda { |v| v =~ Regexp.new("/^(arn:(aws[a-zA-Z-]*)?:lambda:)?([a-z]{2}((-gov)|(-iso(b?)))?-[a-z]+-\d{1}:)?(\d{12}:)?(function:)?([a-zA-Z0-9-_]+)(:((?!\d+)[0-9a-zA-Z_]+))?$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the function associated with the Function URL.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Lambda::Url"
rest_api_document "/AWS::Lambda::Url"

rest_property_map({
  auth_type:           "AuthType",
  cors:                "Cors",
  invoke_mode:         "InvokeMode",
  qualifier:           "Qualifier",
  target_function_arn: "TargetFunctionArn",
})

rest_post_only_properties %i{
  qualifier target_function_arn
}
