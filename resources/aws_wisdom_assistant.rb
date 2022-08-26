# Import API specifics
use "awscc_base"

resource_name :aws_wisdom_assistant
provides :aws_wisdom_assistant, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::Wisdom::Assistant Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: ""

property :server_side_encryption_configuration, Hash,
         callbacks: {
           "Subproperty `KmsKeyId` is not a String" => lambda { |v| v[:KmsKeyId].is_a? String },
           "Subproperty `KmsKeyId` needs to be 1..4096 characters" => lambda { |v| v[:KmsKeyId].length >= 1 && v[:KmsKeyId].length <= 4096 },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :type, Hash,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `AGENT`" => lambda { |v| %w{AGENT}.include? v },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Wisdom::Assistant"
rest_api_document "/AWS::Wisdom::Assistant"

rest_property_map({
  description:                          "Description",
  name:                                 "Name",
  server_side_encryption_configuration: "ServerSideEncryptionConfiguration",
  tags:                                 "Tags",
  type:                                 "Type",
})

rest_post_only_properties %i{
  description name server_side_encryption_configuration tags type
}
