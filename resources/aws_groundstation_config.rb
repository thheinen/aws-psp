# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_groundstation_config
provides :aws_groundstation_config, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  AWS Ground Station config resource type for CloudFormation.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :config_data, Hash,
         required: true,
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern ^[ a-zA-Z0-9_:-]{1,256}$" => lambda { |v| v =~ Regexp.new("/^[ a-zA-Z0-9_:-]{1,256}$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::GroundStation::Config"
rest_api_document "/AWS::GroundStation::Config"

rest_property_map({
  config_data: "ConfigData",
  name:        "Name",
  tags:        "Tags",
})

