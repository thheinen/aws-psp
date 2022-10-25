# Import API specifics
use "awscc_base"

resource_name :aws_iot_fleet_wise_decoder_manifest
provides :aws_iot_fleet_wise_decoder_manifest, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::IoTFleetWise::DecoderManifest Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
           "description must match pattern ^[^\u0000-\u001F\u007F]+$" => lambda { |v| v =~ Regexp.new("/^[^\u0000-\u001F\u007F]+$/") },
         },
         description: ""

property :model_manifest_arn, String,
         required: true,
         callbacks: {
           "model_manifest_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "name must match pattern ^[a-zA-Z\d\-_:]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z\d\-_:]+$/") },
         },
         description: ""

property :network_interfaces, Array,
         callbacks: {
           "network_interfaces is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :signal_decoders, Array,
         callbacks: {
           "signal_decoders is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :status, Hash,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
           "statusis not one of `ACTIVE`, `DRAFT`" => lambda { |v| %w{ACTIVE DRAFT}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IoTFleetWise::DecoderManifest"
rest_api_document "/AWS::IoTFleetWise::DecoderManifest"

rest_property_map({
  description:        "Description",
  model_manifest_arn: "ModelManifestArn",
  name:               "Name",
  network_interfaces: "NetworkInterfaces",
  signal_decoders:    "SignalDecoders",
  status:             "Status",
  tags:               "Tags",
})

rest_post_only_properties %i{
  model_manifest_arn name
}
