# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_iot_sitewise_access_policy
provides :aws_iot_sitewise_access_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::IoTSiteWise::AccessPolicy
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :access_policy_identity, Hash,
         required: true,
         description: <<~'DESCRIPTION'
           The identity for this access policy. Choose either a user or a group but not both.
         DESCRIPTION

property :access_policy_permission, String,
         required: true,
         callbacks: {
           "access_policy_permission is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The permission level for this access policy. Valid values are ADMINISTRATOR or VIEWER.
         DESCRIPTION

property :access_policy_resource, Hash,
         required: true,
         description: <<~'DESCRIPTION'
           The AWS IoT SiteWise Monitor resource for this access policy. Choose either portal or project but not both.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoTSiteWise::AccessPolicy"
rest_api_document "/AWS::IoTSiteWise::AccessPolicy"

rest_property_map({
  access_policy_identity:   "AccessPolicyIdentity",
  access_policy_permission: "AccessPolicyPermission",
  access_policy_resource:   "AccessPolicyResource",
})

