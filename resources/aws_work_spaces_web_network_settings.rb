# Import API specifics
use "awscc_base"

resource_name :aws_work_spaces_web_network_settings
provides :aws_work_spaces_web_network_settings, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::WorkSpacesWeb::NetworkSettings Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :security_group_ids, Array,
         required: true,
         callbacks: {
           "security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :subnet_ids, Array,
         required: true,
         callbacks: {
           "subnet_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :vpc_id, String,
         required: true,
         callbacks: {
           "vpc_id is not a String" => lambda { |v| v.is_a? String },
           "vpc_id needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "vpc_id must match pattern ^vpc-[0-9a-z]*$" => lambda { |v| v =~ Regexp.new("/^vpc-[0-9a-z]*$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::WorkSpacesWeb::NetworkSettings"
rest_api_document "/AWS::WorkSpacesWeb::NetworkSettings"

rest_property_map({
  security_group_ids: "SecurityGroupIds",
  subnet_ids:         "SubnetIds",
  tags:               "Tags",
  vpc_id:             "VpcId",
})

