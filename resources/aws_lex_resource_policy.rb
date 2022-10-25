# Import API specifics
use "awscc_base"

resource_name :aws_lex_resource_policy
provides :aws_lex_resource_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A resource policy with specified policy statements that attaches to a Lex bot or bot alias.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :policy, Hash,
         required: true,
         callbacks: {
           "policy is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :resource_arn, Hash,
         required: true,
         callbacks: {
           "resource_arn is not a String" => lambda { |v| v.is_a? String },
           "resource_arn needs to be 1..1011 characters" => lambda { |v| v.length >= 1 && v.length <= 1011 },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Lex::ResourcePolicy"
rest_api_document "/AWS::Lex::ResourcePolicy"

rest_property_map({
  policy:       "Policy",
  resource_arn: "ResourceArn",
})

