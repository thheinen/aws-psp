# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_lightsail_static_ip
provides :aws_lightsail_static_ip, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Lightsail::StaticIp
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :attached_to, String,
         callbacks: {
           "attached_to is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The instance where the static IP is attached.
         DESCRIPTION

property :static_ip_name, String,
         required: true,
         callbacks: {
           "static_ip_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the static IP address.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Lightsail::StaticIp"
rest_api_document "/AWS::Lightsail::StaticIp"

rest_property_map({
  attached_to:    "AttachedTo",
  static_ip_name: "StaticIpName",
})

rest_post_only_properties %i{
  static_ip_name
}
