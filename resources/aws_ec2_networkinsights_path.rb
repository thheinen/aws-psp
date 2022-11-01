# Import API specifics
use "awscc_base"

resource_name :aws_ec2_networkinsights_path
provides :aws_ec2_networkinsights_path, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::EC2::NetworkInsightsPath
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :destination, String,
         required: true,
         callbacks: {
           "destination is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :destination_ip, Hash,
         callbacks: {
           "destination_ip is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :destination_port, Hash,
         callbacks: {
           "destination_port is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :protocol, Hash,
         required: true,
         callbacks: {
           "protocol is not a String" => lambda { |v| v.is_a? String },
           "protocolis not one of `tcp`, `udp`" => lambda { |v| %w{tcp udp}.include? v },
         },
         description: ""

property :source, String,
         required: true,
         callbacks: {
           "source is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :source_ip, Hash,
         callbacks: {
           "source_ip is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::EC2::NetworkInsightsPath"
rest_api_document "/AWS::EC2::NetworkInsightsPath"

rest_property_map({
  destination:      "Destination",
  destination_ip:   "DestinationIp",
  destination_port: "DestinationPort",
  protocol:         "Protocol",
  source:           "Source",
  source_ip:        "SourceIp",
  tags:             "Tags",
})

rest_post_only_properties %i{
  destination destination_ip destination_port protocol source source_ip
}
