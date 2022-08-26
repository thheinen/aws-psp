# Import API specifics
use "awscc_base"

resource_name :aws_appstream_application_entitlement_association
provides :aws_appstream_application_entitlement_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::AppStream::ApplicationEntitlementAssociation
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :application_identifier, String,
         required: true,
         callbacks: {
           "application_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :entitlement_name, String,
         required: true,
         callbacks: {
           "entitlement_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :stack_name, String,
         required: true,
         callbacks: {
           "stack_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::AppStream::ApplicationEntitlementAssociation"
rest_api_document "/AWS::AppStream::ApplicationEntitlementAssociation"

rest_property_map({
  application_identifier: "ApplicationIdentifier",
  entitlement_name:       "EntitlementName",
  stack_name:             "StackName",
})

rest_post_only_properties %i{
  application_identifier entitlement_name stack_name
}
