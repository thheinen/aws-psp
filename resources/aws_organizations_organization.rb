# Import API specifics
use "awscc_base"

resource_name :aws_organizations_organization
provides :aws_organizations_organization, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Organizations::Organization
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :feature_set, String,
         callbacks: {
           "feature_set is not a String" => lambda { |v| v.is_a? String },
           "feature_setis not one of `ALL`, `CONSOLIDATED_BILLING`" => lambda { |v| %w{ALL CONSOLIDATED_BILLING}.include? v },
         },
         description: <<~'DESCRIPTION'
           Specifies the feature set supported by the new organization. Each feature set supports different levels of functionality.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Organizations::Organization"
rest_api_document "/AWS::Organizations::Organization"

rest_property_map({
  feature_set: "FeatureSet",
})

