# Import API specifics
use "awscc_base"

resource_name :aws_open_search_serverless_access_policy
provides :aws_open_search_serverless_access_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Amazon OpenSearchServerless access policy resource
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..1000 characters" => lambda { |v| v.length >= 1 && v.length <= 1000 },
         },
         description: <<~'DESCRIPTION'
           The description of the policy
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 3..32 characters" => lambda { |v| v.length >= 3 && v.length <= 32 },
           "name must match pattern ^[a-z][a-z0-9-]{2,31}$" => lambda { |v| v =~ Regexp.new("/^[a-z][a-z0-9-]{2,31}$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the policy
         DESCRIPTION

property :policy, String,
         callbacks: {
           "policy is not a String" => lambda { |v| v.is_a? String },
           "policy needs to be 1..20480 characters" => lambda { |v| v.length >= 1 && v.length <= 20480 },
           "policy must match pattern [\u0009\u000A\u000D\u0020-\u007E\u00A1-\u00FF]+" => lambda { |v| v =~ Regexp.new("/[\u0009\u000A\u000D\u0020-\u007E\u00A1-\u00FF]+/") },
         },
         description: <<~'DESCRIPTION'
           The JSON policy document that is the content for the policy
         DESCRIPTION

property :type, Hash,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `data`" => lambda { |v| %w{data}.include? v },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::OpenSearchServerless::AccessPolicy"
rest_api_document "/AWS::OpenSearchServerless::AccessPolicy"

rest_property_map({
  description: "Description",
  name:        "Name",
  policy:      "Policy",
  type:        "Type",
})

rest_post_only_properties %i{
  name type
}
