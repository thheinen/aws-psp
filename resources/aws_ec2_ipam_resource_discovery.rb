# Import API specifics
use "awscc_base"

resource_name :aws_ec2_ipam_resource_discovery
provides :aws_ec2_ipam_resource_discovery, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Schema of AWS::EC2::IPAMResourceDiscovery Type
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
         description: <<~'DESCRIPTION'
           The regions Resource Discovery is enabled for. Allows resource discoveries to be created in these regions, as well as enabling monitoring
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::IPAMResourceDiscovery"
rest_api_document "/AWS::EC2::IPAMResourceDiscovery"

rest_property_map({
  description:       "Description",
  operating_regions: "OperatingRegions",
  tags:              "Tags",
})

