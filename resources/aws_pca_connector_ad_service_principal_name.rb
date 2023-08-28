# Import API specifics
use "awscc_base"

resource_name :aws_pca_connector_ad_service_principal_name
provides :aws_pca_connector_ad_service_principal_name, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::PCAConnectorAD::ServicePrincipalName Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :connector_arn, String,
         callbacks: {
           "connector_arn is not a String" => lambda { |v| v.is_a? String },
           "connector_arn needs to be 5..200 characters" => lambda { |v| v.length >= 5 && v.length <= 200 },
           "connector_arn must match pattern ^arn:[\w-]+:pca-connector-ad:[\w-]+:[0-9]+:connector(\/[\w-]+)$" => lambda { |v| v =~ Regexp.new("/^arn:[\w-]+:pca-connector-ad:[\w-]+:[0-9]+:connector(\/[\w-]+)$/") },
         },
         description: ""

property :directory_registration_arn, String,
         callbacks: {
           "directory_registration_arn is not a String" => lambda { |v| v.is_a? String },
           "directory_registration_arn needs to be 5..200 characters" => lambda { |v| v.length >= 5 && v.length <= 200 },
           "directory_registration_arn must match pattern ^arn:[\w-]+:pca-connector-ad:[\w-]+:[0-9]+:directory-registration(\/[\w-]+)$" => lambda { |v| v =~ Regexp.new("/^arn:[\w-]+:pca-connector-ad:[\w-]+:[0-9]+:directory-registration(\/[\w-]+)$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::PCAConnectorAD::ServicePrincipalName"
rest_api_document "/AWS::PCAConnectorAD::ServicePrincipalName"

rest_property_map({
  connector_arn:              "ConnectorArn",
  directory_registration_arn: "DirectoryRegistrationArn",
})

rest_post_only_properties %i{
  connector_arn directory_registration_arn
}
