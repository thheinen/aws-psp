# Import API specifics
use "awscc_base"

resource_name :aws_ec2_key_pair
provides :aws_ec2_key_pair, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::EC2::KeyPair creates an SSH key pair
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :key_format, String,
         callbacks: {
           "key_format is not a String" => lambda { |v| v.is_a? String },
           "key_formatis not one of `pem`, `ppk`" => lambda { |v| %w{pem ppk}.include? v },
         },
         description: <<~'DESCRIPTION'
           The format of the private key
         DESCRIPTION

property :key_name, String,
         required: true,
         callbacks: {
           "key_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the SSH key pair
         DESCRIPTION

property :key_type, String,
         callbacks: {
           "key_type is not a String" => lambda { |v| v.is_a? String },
           "key_typeis not one of `rsa`, `ed25519`" => lambda { |v| %w{rsa ed25519}.include? v },
         },
         description: <<~'DESCRIPTION'
           The crypto-system used to generate a key pair.
         DESCRIPTION

property :public_key_material, String,
         callbacks: {
           "public_key_material is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Plain text public key to import
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::KeyPair"
rest_api_document "/AWS::EC2::KeyPair"

rest_property_map({
  key_format:          "KeyFormat",
  key_name:            "KeyName",
  key_type:            "KeyType",
  public_key_material: "PublicKeyMaterial",
  tags:                "Tags",
})

rest_post_only_properties %i{
  key_format key_name key_type public_key_material tags
}
