# Import API specifics
use "awscc_base"

resource_name :aws_ec2_vpc_endpoint_service_permissions
provides :aws_ec2_vpc_endpoint_service_permissions, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::VPCEndpointServicePermissions
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :allowed_principals, Array,
         callbacks: {
           "allowed_principals is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :service_id, String,
         required: true,
         callbacks: {
           "service_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::EC2::VPCEndpointServicePermissions"
rest_api_document "/AWS::EC2::VPCEndpointServicePermissions"

rest_property_map({
  allowed_principals: "AllowedPrincipals",
  service_id:         "ServiceId",
})

rest_post_only_properties %i{
  service_id
}
