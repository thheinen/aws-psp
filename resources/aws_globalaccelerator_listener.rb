# Import API specifics
use "awscc_base"

resource_name :aws_globalaccelerator_listener
provides :aws_globalaccelerator_listener, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::GlobalAccelerator::Listener
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :accelerator_arn, String,
         required: true,
         callbacks: {
           "accelerator_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the accelerator.
         DESCRIPTION

property :client_affinity, String,
         callbacks: {
           "client_affinity is not a String" => lambda { |v| v.is_a? String },
           "client_affinityis not one of `NONE`, `SOURCE_IP`" => lambda { |v| %w{NONE SOURCE_IP}.include? v },
         },
         description: <<~'DESCRIPTION'
           Client affinity lets you direct all requests from a user to the same endpoint.
         DESCRIPTION

property :port_ranges, Array,
         required: true,
         callbacks: {
           "port_ranges is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :protocol, String,
         required: true,
         callbacks: {
           "protocol is not a String" => lambda { |v| v.is_a? String },
           "protocolis not one of `TCP`, `UDP`" => lambda { |v| %w{TCP UDP}.include? v },
         },
         description: <<~'DESCRIPTION'
           The protocol for the listener.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::GlobalAccelerator::Listener"
rest_api_document "/AWS::GlobalAccelerator::Listener"

rest_property_map({
  accelerator_arn: "AcceleratorArn",
  client_affinity: "ClientAffinity",
  port_ranges:     "PortRanges",
  protocol:        "Protocol",
})

rest_post_only_properties %i{
  accelerator_arn
}
