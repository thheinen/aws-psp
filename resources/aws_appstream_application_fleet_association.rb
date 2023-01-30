# Import API specifics
use "awscc_base"

resource_name :aws_appstream_application_fleet_association
provides :aws_appstream_application_fleet_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::AppStream::ApplicationFleetAssociation
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :application_arn, Hash,
         required: true,
         callbacks: {
           "application_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :fleet_name, String,
         required: true,
         callbacks: {
           "fleet_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::AppStream::ApplicationFleetAssociation"
rest_api_document "/AWS::AppStream::ApplicationFleetAssociation"

rest_property_map({
  application_arn: "ApplicationArn",
  fleet_name:      "FleetName",
})

rest_post_only_properties %i{
  application_arn fleet_name
}
