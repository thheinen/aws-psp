# Import API specifics
use "awscc_base"

resource_name :aws_iot_fleet_wise_vehicle
provides :aws_iot_fleet_wise_vehicle, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::IoTFleetWise::Vehicle Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :association_behavior, Hash,
         callbacks: {
           "association_behavior is not a String" => lambda { |v| v.is_a? String },
           "association_behavioris not one of `CreateIotThing`, `ValidateIotThingExists`" => lambda { |v| %w{CreateIotThing ValidateIotThingExists}.include? v },
         },
         description: ""

property :attributes, Hash,
         callbacks: {
           "attributes is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :decoder_manifest_arn, String,
         required: true,
         callbacks: {
           "decoder_manifest_arn is not a String" => lambda { |v| v.is_a? String },
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

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IoTFleetWise::Vehicle"
rest_api_document "/AWS::IoTFleetWise::Vehicle"

rest_property_map({
  association_behavior: "AssociationBehavior",
  attributes:           "Attributes",
  decoder_manifest_arn: "DecoderManifestArn",
  model_manifest_arn:   "ModelManifestArn",
  name:                 "Name",
  tags:                 "Tags",
})

rest_post_only_properties %i{
  name
}
