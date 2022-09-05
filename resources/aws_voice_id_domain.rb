# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_voice_id_domain
provides :aws_voice_id_domain, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::VoiceID::Domain resource specifies an Amazon VoiceID Domain.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
           "description must match pattern ^([\p{L}\p{Z}\p{N}_.:/=+\-%@]*)$" => lambda { |v| v =~ Regexp.new("/^([\p{L}\p{Z}\p{N}_.:/=+\-%@]*)$/") },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "name must match pattern ^[a-zA-Z0-9][a-zA-Z0-9_-]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9][a-zA-Z0-9_-]*$/") },
         },
         description: ""

property :server_side_encryption_configuration, Hash,
         required: true,
         callbacks: {
           "Subproperty `KmsKeyId` is not a String" => lambda { |v| v[:KmsKeyId].is_a? String },
           "Subproperty `KmsKeyId` needs to be 1..2048 characters" => lambda { |v| v[:KmsKeyId].length >= 1 && v[:KmsKeyId].length <= 2048 },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::VoiceID::Domain"
rest_api_document "/AWS::VoiceID::Domain"

rest_property_map({
  description:                          "Description",
  name:                                 "Name",
  server_side_encryption_configuration: "ServerSideEncryptionConfiguration",
  tags:                                 "Tags",
})

