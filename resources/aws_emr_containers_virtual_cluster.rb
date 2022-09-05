# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_emr_containers_virtual_cluster
provides :aws_emr_containers_virtual_cluster, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Schema of AWS::EMRContainers::VirtualCluster Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :container_provider, Hash,
         required: true,
         callbacks: {
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
           "Subproperty `Id` is not a String" => lambda { |v| v[:Id].is_a? String },
           "Subproperty `Id` needs to be 1..100 characters" => lambda { |v| v[:Id].length >= 1 && v[:Id].length <= 100 },
           "Subproperty `Id` must match pattern ^[0-9A-Za-z][A-Za-z0-9\-_]*" => lambda { |v| v[:Id] =~ Regexp.new("/^[0-9A-Za-z][A-Za-z0-9\-_]*/") },
         },
         description: <<~'DESCRIPTION'
           Container provider of the virtual cluster.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "name must match pattern [\.\-_/#A-Za-z0-9]+" => lambda { |v| v =~ Regexp.new("/[\.\-_/#A-Za-z0-9]+/") },
         },
         description: <<~'DESCRIPTION'
           Name of the virtual cluster.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this virtual cluster.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EMRContainers::VirtualCluster"
rest_api_document "/AWS::EMRContainers::VirtualCluster"

rest_property_map({
  container_provider: "ContainerProvider",
  name:               "Name",
  tags:               "Tags",
})

rest_post_only_properties %i{
  container_provider name
}
