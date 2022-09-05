# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ivs_playback_key_pair
provides :aws_ivs_playback_key_pair, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IVS::PlaybackKeyPair
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 0..128 characters" => lambda { |v| v.length >= 0 && v.length <= 128 },
           "name must match pattern ^[a-zA-Z0-9-_]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-_]*$/") },
         },
         description: <<~'DESCRIPTION'
           An arbitrary string (a nickname) assigned to a playback key pair that helps the customer identify that resource. The value does not need to be unique.
         DESCRIPTION

property :public_key_material, String,
         required: true,
         callbacks: {
           "public_key_material is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The public portion of a customer-generated key pair.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of key-value pairs that contain metadata for the asset model.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IVS::PlaybackKeyPair"
rest_api_document "/AWS::IVS::PlaybackKeyPair"

rest_property_map({
  name:                "Name",
  public_key_material: "PublicKeyMaterial",
  tags:                "Tags",
})

rest_post_only_properties %i{
  name public_key_material
}
