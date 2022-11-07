# Import API specifics
use "awscc_base"

resource_name :aws_appstream_directory_config
provides :aws_appstream_directory_config, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::AppStream::DirectoryConfig
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :certificate_based_auth_properties, Hash,
         callbacks: {
           "Subproperty `Status` is not a String" => lambda { |v| v[:Status].is_a? String },
           "Subproperty `CertificateAuthorityArn` is not a String" => lambda { |v| v[:CertificateAuthorityArn].is_a? String },
           "Subproperty `CertificateAuthorityArn`is not a valid ARN" => lambda { |v| v[:CertificateAuthorityArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :directory_name, String,
         required: true,
         callbacks: {
           "directory_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :organizational_unit_distinguished_names, Array,
         required: true,
         callbacks: {
           "organizational_unit_distinguished_names is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :service_account_credentials, Hash,
         required: true,
         callbacks: {
           "Subproperty `AccountName` is not a String" => lambda { |v| v[:AccountName].is_a? String },
           "Subproperty `AccountPassword` is not a String" => lambda { |v| v[:AccountPassword].is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::AppStream::DirectoryConfig"
rest_api_document "/AWS::AppStream::DirectoryConfig"

rest_property_map({
  certificate_based_auth_properties:       "CertificateBasedAuthProperties",
  directory_name:                          "DirectoryName",
  organizational_unit_distinguished_names: "OrganizationalUnitDistinguishedNames",
  service_account_credentials:             "ServiceAccountCredentials",
})

rest_post_only_properties %i{
  directory_name
}
