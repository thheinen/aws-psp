# Import API specifics
use "awscc_base"

resource_name :aws_ec2_ipam
provides :aws_ec2_ipam, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Schema of AWS::EC2::IPAM Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :operating_regions, Array,
         callbacks: {
           "operating_regions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The regions IPAM is enabled for. Allows pools to be created in these regions, as well as enabling monitoring"

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of key-value pairs to apply to this resource."

# API URLs and mappings
rest_api_collection "/AWS::EC2::IPAM"
rest_api_document "/AWS::EC2::IPAM"

rest_property_map({
  description:       "Description",
  operating_regions: "OperatingRegions",
  tags:              "Tags",
})

