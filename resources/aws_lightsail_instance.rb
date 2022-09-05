# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_lightsail_instance
provides :aws_lightsail_instance, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Lightsail::Instance
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :add_ons, Array,
         callbacks: {
           "add_ons is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of objects representing the add-ons to enable for the new instance.
         DESCRIPTION

property :availability_zone, String,
         callbacks: {
           "availability_zone is not a String" => lambda { |v| v.is_a? String },
           "availability_zone needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The Availability Zone in which to create your instance. Use the following format: us-east-2a (case sensitive). Be sure to add the include Availability Zones parameter to your request.
         DESCRIPTION

property :blueprint_id, String,
         required: true,
         callbacks: {
           "blueprint_id is not a String" => lambda { |v| v.is_a? String },
           "blueprint_id needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The ID for a virtual private server image (e.g., app_wordpress_4_4 or app_lamp_7_0 ). Use the get blueprints operation to return a list of available images (or blueprints ).
         DESCRIPTION

property :bundle_id, String,
         required: true,
         callbacks: {
           "bundle_id is not a String" => lambda { |v| v.is_a? String },
           "bundle_id needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The bundle of specification information for your virtual private server (or instance ), including the pricing plan (e.g., micro_1_0 ).
         DESCRIPTION

property :hardware, Hash,
         callbacks: {
           "Subproperty `CpuCount` is not a Integer" => lambda { |v| v[:CpuCount].is_a? Integer },
           "Subproperty `RamSizeInGb` is not a Integer" => lambda { |v| v[:RamSizeInGb].is_a? Integer },
           "Subproperty `Disks` is not a Array" => lambda { |v| v[:Disks].is_a? Array },
         },
         description: ""

property :instance_name, String,
         required: true,
         callbacks: {
           "instance_name is not a String" => lambda { |v| v.is_a? String },
           "instance_name needs to be 1..254 characters" => lambda { |v| v.length >= 1 && v.length <= 254 },
           "instance_name must match pattern ^[a-zA-Z0-9][\w\-.]*[a-zA-Z0-9]$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9][\w\-.]*[a-zA-Z0-9]$/") },
         },
         description: <<~'DESCRIPTION'
           The names to use for your new Lightsail instance.
         DESCRIPTION

property :key_pair_name, String,
         callbacks: {
           "key_pair_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of your key pair.
         DESCRIPTION

property :location, Hash,
         callbacks: {
           "Subproperty `AvailabilityZone` is not a String" => lambda { |v| v[:AvailabilityZone].is_a? String },
           "Subproperty `RegionName` is not a String" => lambda { |v| v[:RegionName].is_a? String },
         },
         description: ""

property :networking, Hash,
         callbacks: {
           "Subproperty `Ports` is not a Array" => lambda { |v| v[:Ports].is_a? Array },
         },
         description: ""

property :state, Hash,
         callbacks: {
           "Subproperty `Code` is not a Integer" => lambda { |v| v[:Code].is_a? Integer },
           "Subproperty `Name` is not a String" => lambda { |v| v[:Name].is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :user_data, String,
         callbacks: {
           "user_data is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A launch script you can create that configures a server with additional user data. For example, you might want to run apt-get -y update.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Lightsail::Instance"
rest_api_document "/AWS::Lightsail::Instance"

rest_property_map({
  add_ons:           "AddOns",
  availability_zone: "AvailabilityZone",
  blueprint_id:      "BlueprintId",
  bundle_id:         "BundleId",
  hardware:          "Hardware",
  instance_name:     "InstanceName",
  key_pair_name:     "KeyPairName",
  location:          "Location",
  networking:        "Networking",
  state:             "State",
  tags:              "Tags",
  user_data:         "UserData",
})

rest_post_only_properties %i{
  availability_zone blueprint_id bundle_id instance_name
}
