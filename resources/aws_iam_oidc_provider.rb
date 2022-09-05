# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_iam_oidc_provider
provides :aws_iam_oidc_provider, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IAM::OIDCProvider
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :client_id_list, Array,
         callbacks: {
           "client_id_list is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :thumbprint_list, Array,
         required: true,
         callbacks: {
           "thumbprint_list is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :url, String,
         callbacks: {
           "url is not a String" => lambda { |v| v.is_a? String },
           "url needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IAM::OIDCProvider"
rest_api_document "/AWS::IAM::OIDCProvider"

rest_property_map({
  client_id_list:  "ClientIdList",
  tags:            "Tags",
  thumbprint_list: "ThumbprintList",
  url:             "Url",
})

rest_post_only_properties %i{
  url
}
