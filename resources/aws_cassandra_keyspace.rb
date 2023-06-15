# Import API specifics
use "awscc_base"

resource_name :aws_cassandra_keyspace
provides :aws_cassandra_keyspace, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Cassandra::Keyspace
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :keyspace_name, String,
         callbacks: {
           "keyspace_name is not a String" => lambda { |v| v.is_a? String },
           "keyspace_name must match pattern ^[a-zA-Z0-9][a-zA-Z0-9_]{1,47}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9][a-zA-Z0-9_]{1,47}$/") },
         },
         description: <<~'DESCRIPTION'
           Name for Cassandra keyspace
         DESCRIPTION

property :replication_specification, Hash,
         callbacks: {
           "Subproperty `ReplicationStrategy` is not a String" => lambda { |v| v[:ReplicationStrategy].is_a? String },
           "Subproperty `ReplicationStrategy`is not one of `SINGLE_REGION`, `MULTI_REGION`" => lambda { |v| %w{SINGLE_REGION MULTI_REGION}.include? v[:ReplicationStrategy] },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Cassandra::Keyspace"
rest_api_document "/AWS::Cassandra::Keyspace"

rest_property_map({
  keyspace_name:             "KeyspaceName",
  replication_specification: "ReplicationSpecification",
  tags:                      "Tags",
})

rest_post_only_properties %i{
  keyspace_name replication_specification
}
