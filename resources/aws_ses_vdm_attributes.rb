# Import API specifics
use "awscc_base"

resource_name :aws_ses_vdm_attributes
provides :aws_ses_vdm_attributes, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SES::VdmAttributes
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :dashboard_attributes, Hash,
         callbacks: {
           "Subproperty `EngagementMetrics` is not a String" => lambda { |v| v[:EngagementMetrics].is_a? String },
           "Subproperty `EngagementMetrics` must match pattern ENABLED|DISABLED" => lambda { |v| v[:EngagementMetrics] =~ Regexp.new("/ENABLED|DISABLED/") },
         },
         description: ""

property :guardian_attributes, Hash,
         callbacks: {
           "Subproperty `OptimizedSharedDelivery` is not a String" => lambda { |v| v[:OptimizedSharedDelivery].is_a? String },
           "Subproperty `OptimizedSharedDelivery` must match pattern ENABLED|DISABLED" => lambda { |v| v[:OptimizedSharedDelivery] =~ Regexp.new("/ENABLED|DISABLED/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::SES::VdmAttributes"
rest_api_document "/AWS::SES::VdmAttributes"

rest_property_map({
  dashboard_attributes: "DashboardAttributes",
  guardian_attributes:  "GuardianAttributes",
})

