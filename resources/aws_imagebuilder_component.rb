# Import API specifics
use "awscc_base"

resource_name :aws_imagebuilder_component
provides :aws_imagebuilder_component, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::ImageBuilder::Component
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :change_description, String,
         callbacks: {
           "change_description is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The change description of the component."

property :data, String,
         callbacks: {
           "data is not a String" => lambda { |v| v.is_a? String },
           "data needs to be 1..16000 characters" => lambda { |v| v.length >= 1 && v.length <= 16000 },
         },
         description: "The data of the component."

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The description of the component."

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The KMS key identifier used to encrypt the component."

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The name of the component."

property :platform, String,
         required: true,
         callbacks: {
           "platform is not a String" => lambda { |v| v.is_a? String },
           "platformis not one of `Windows`, `Linux`" => lambda { |v| %w{Windows Linux}.include? v },
         },
         description: "The platform of the component."

property :supported_os_versions, Array,
         callbacks: {
           "supported_os_versions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The operating system (OS) version supported by the component."

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: "The tags associated with the component."

property :uri, String,
         callbacks: {
           "uri is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The uri of the component."

property :version, String,
         required: true,
         callbacks: {
           "version is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The version of the component."

# API URLs and mappings
rest_api_collection "/AWS::ImageBuilder::Component"
rest_api_document "/AWS::ImageBuilder::Component"

rest_property_map({
  change_description:    "ChangeDescription",
  data:                  "Data",
  description:           "Description",
  kms_key_id:            "KmsKeyId",
  name:                  "Name",
  platform:              "Platform",
  supported_os_versions: "SupportedOsVersions",
  tags:                  "Tags",
  uri:                   "Uri",
  version:               "Version",
})

rest_post_only_properties %i{
  change_description data description kms_key_id name platform supported_os_versions tags uri version
}
