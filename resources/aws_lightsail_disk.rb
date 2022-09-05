# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_lightsail_disk
provides :aws_lightsail_disk, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Lightsail::Disk
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

property :disk_name, String,
         required: true,
         callbacks: {
           "disk_name is not a String" => lambda { |v| v.is_a? String },
           "disk_name needs to be 1..254 characters" => lambda { |v| v.length >= 1 && v.length <= 254 },
           "disk_name must match pattern ^[a-zA-Z0-9][\w\-.]*[a-zA-Z0-9]$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9][\w\-.]*[a-zA-Z0-9]$/") },
         },
         description: <<~'DESCRIPTION'
           The names to use for your new Lightsail disk.
         DESCRIPTION

property :size_in_gb, Integer,
         required: true,
         callbacks: {
           "size_in_gb is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Size of the Lightsail disk
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Lightsail::Disk"
rest_api_document "/AWS::Lightsail::Disk"

rest_property_map({
  add_ons:           "AddOns",
  availability_zone: "AvailabilityZone",
  disk_name:         "DiskName",
  size_in_gb:        "SizeInGb",
  tags:              "Tags",
})

rest_post_only_properties %i{
  availability_zone disk_name size_in_gb
}
