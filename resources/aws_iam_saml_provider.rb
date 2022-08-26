# Import API specifics
use "awscc_base"

resource_name :aws_iam_saml_provider
provides :aws_iam_saml_provider, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IAM::SAMLProvider
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "name must match pattern [\w._-]+" => lambda { |v| v =~ Regexp.new("/[\w._-]+/") },
         },
         description: ""

property :saml_metadata_document, String,
         required: true,
         callbacks: {
           "saml_metadata_document is not a String" => lambda { |v| v.is_a? String },
           "saml_metadata_document needs to be 1000..10000000 characters" => lambda { |v| v.length >= 1000 && v.length <= 10000000 },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IAM::SAMLProvider"
rest_api_document "/AWS::IAM::SAMLProvider"

rest_property_map({
  name:                   "Name",
  saml_metadata_document: "SamlMetadataDocument",
  tags:                   "Tags",
})

rest_post_only_properties %i{
  name
}
