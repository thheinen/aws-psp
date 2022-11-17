# Import API specifics
use "awscc_base"

resource_name :aws_ec2_ipam_scope
provides :aws_ec2_ipam_scope, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Schema of AWS::EC2::IPAMScope Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :ipam_id, String,
         required: true,
         callbacks: {
           "ipam_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Id of the IPAM this scope is a part of.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::IPAMScope"
rest_api_document "/AWS::EC2::IPAMScope"

rest_property_map({
  description: "Description",
  ipam_id:     "IpamId",
  tags:        "Tags",
})

rest_post_only_properties %i{
  ipam_id
}
