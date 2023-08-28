# Import API specifics
use "awscc_base"

resource_name :aws_pca_connector_ad_connector
provides :aws_pca_connector_ad_connector, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::PCAConnectorAD::Connector Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :certificate_authority_arn, String,
         required: true,
         callbacks: {
           "certificate_authority_arn is not a String" => lambda { |v| v.is_a? String },
           "certificate_authority_arn needs to be 5..200 characters" => lambda { |v| v.length >= 5 && v.length <= 200 },
           "certificate_authority_arn must match pattern ^arn:[\w-]+:acm-pca:[\w-]+:[0-9]+:certificate-authority(\/[\w-]+)$" => lambda { |v| v =~ Regexp.new("/^arn:[\w-]+:acm-pca:[\w-]+:[0-9]+:certificate-authority(\/[\w-]+)$/") },
         },
         description: ""

property :directory_id, String,
         required: true,
         callbacks: {
           "directory_id is not a String" => lambda { |v| v.is_a? String },
           "directory_id must match pattern ^d-[0-9a-f]{10}$" => lambda { |v| v =~ Regexp.new("/^d-[0-9a-f]{10}$/") },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :vpc_information, Hash,
         required: true,
         callbacks: {
           "Subproperty `SecurityGroupIds` is not a Array" => lambda { |v| v[:SecurityGroupIds].is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::PCAConnectorAD::Connector"
rest_api_document "/AWS::PCAConnectorAD::Connector"

rest_property_map({
  certificate_authority_arn: "CertificateAuthorityArn",
  directory_id:              "DirectoryId",
  tags:                      "Tags",
  vpc_information:           "VpcInformation",
})

rest_post_only_properties %i{
  certificate_authority_arn directory_id vpc_information
}
