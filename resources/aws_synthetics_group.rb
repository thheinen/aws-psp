# Import API specifics
use "awscc_base"

resource_name :aws_synthetics_group
provides :aws_synthetics_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Synthetics::Group
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern ^[0-9a-z_\-]{1,64}$" => lambda { |v| v =~ Regexp.new("/^[0-9a-z_\-]{1,64}$/") },
         },
         description: <<~'DESCRIPTION'
           Name of the group.
         DESCRIPTION

property :resource_arns, Array,
         callbacks: {
           "resource_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Synthetics::Group"
rest_api_document "/AWS::Synthetics::Group"

rest_property_map({
  name:          "Name",
  resource_arns: "ResourceArns",
  tags:          "Tags",
})

rest_post_only_properties %i{
  name
}
