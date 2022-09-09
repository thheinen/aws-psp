# Import API specifics
use "awscc_base"

resource_name :aws_iot_role_alias
provides :aws_iot_role_alias, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Use the AWS::IoT::RoleAlias resource to declare an AWS IoT RoleAlias.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :credential_duration_seconds, Integer,
         callbacks: {
           "credential_duration_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :role_alias, String,
         callbacks: {
           "role_alias is not a String" => lambda { |v| v.is_a? String },
           "role_alias needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "role_alias must match pattern [\w=,@-]+" => lambda { |v| v =~ Regexp.new("/[\w=,@-]+/") },
         },
         description: ""

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "role_arn must match pattern arn:(aws[a-zA-Z-]*)?:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+" => lambda { |v| v =~ Regexp.new("/arn:(aws[a-zA-Z-]*)?:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IoT::RoleAlias"
rest_api_document "/AWS::IoT::RoleAlias"

rest_property_map({
  credential_duration_seconds: "CredentialDurationSeconds",
  role_alias:                  "RoleAlias",
  role_arn:                    "RoleArn",
  tags:                        "Tags",
})

rest_post_only_properties %i{
  role_alias
}
