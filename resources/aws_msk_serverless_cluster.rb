# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_msk_serverless_cluster
provides :aws_msk_serverless_cluster, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::MSK::ServerlessCluster
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :client_authentication, Hash,
         required: true,
         description: ""

property :cluster_name, String,
         required: true,
         callbacks: {
           "cluster_name is not a String" => lambda { |v| v.is_a? String },
           "cluster_name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           A key-value pair to associate with a resource.
         DESCRIPTION

property :vpc_configs, Array,
         required: true,
         callbacks: {
           "vpc_configs is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::MSK::ServerlessCluster"
rest_api_document "/AWS::MSK::ServerlessCluster"

rest_property_map({
  client_authentication: "ClientAuthentication",
  cluster_name:          "ClusterName",
  tags:                  "Tags",
  vpc_configs:           "VpcConfigs",
})

rest_post_only_properties %i{
  client_authentication cluster_name tags vpc_configs
}
