# Import API specifics
use "awscc_base"

resource_name :aws_pca_connector_ad_template
provides :aws_pca_connector_ad_template, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Represents a template that defines certificate configurations, both for issuance and client handling
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :connector_arn, String,
         required: true,
         callbacks: {
           "connector_arn is not a String" => lambda { |v| v.is_a? String },
           "connector_arn needs to be 5..200 characters" => lambda { |v| v.length >= 5 && v.length <= 200 },
           "connector_arn must match pattern ^arn:[\w-]+:pca-connector-ad:[\w-]+:[0-9]+:connector\/[0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12}$" => lambda { |v| v =~ Regexp.new("/^arn:[\w-]+:pca-connector-ad:[\w-]+:[0-9]+:connector\/[0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12}$/") },
         },
         description: ""

property :definition, Hash,
         required: true,
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "name must match pattern ^(?!^\s+$)((?![\x5c'\x2b,;<=>#\x22])([\x20-\x7E]))+$" => lambda { |v| v =~ Regexp.new("/^(?!^\s+$)((?![\x5c'\x2b,;<=>#\x22])([\x20-\x7E]))+$/") },
         },
         description: ""

property :reenroll_all_certificate_holders, [TrueClass, FalseClass],
         callbacks: {
           "reenroll_all_certificate_holders is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::PCAConnectorAD::Template"
rest_api_document "/AWS::PCAConnectorAD::Template"

rest_property_map({
  connector_arn:                    "ConnectorArn",
  definition:                       "Definition",
  name:                             "Name",
  reenroll_all_certificate_holders: "ReenrollAllCertificateHolders",
  tags:                             "Tags",
})

rest_post_only_properties %i{
  connector_arn name
}
