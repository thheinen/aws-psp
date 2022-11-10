# Import API specifics
use "awscc_base"

resource_name :aws_certificate_manager_account
provides :aws_certificate_manager_account, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::CertificateManager::Account.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :expiry_events_configuration, Hash,
         required: true,
         callbacks: {
           "Subproperty `DaysBeforeExpiry` is not a Integer" => lambda { |v| v[:DaysBeforeExpiry].is_a? Integer },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::CertificateManager::Account"
rest_api_document "/AWS::CertificateManager::Account"

rest_property_map({
  expiry_events_configuration: "ExpiryEventsConfiguration",
})

