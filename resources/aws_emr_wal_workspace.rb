# Import API specifics
use "awscc_base"

resource_name :aws_emr_wal_workspace
provides :aws_emr_wal_workspace, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::EMR::WALWorkspace Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :wal_workspace_name, String,
         callbacks: {
           "wal_workspace_name is not a String" => lambda { |v| v.is_a? String },
           "wal_workspace_name needs to be 1..32 characters" => lambda { |v| v.length >= 1 && v.length <= 32 },
           "wal_workspace_name must match pattern ^[a-zA-Z0-9]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9]+$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the emrwal container
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EMR::WALWorkspace"
rest_api_document "/AWS::EMR::WALWorkspace"

rest_property_map({
  tags:               "Tags",
  wal_workspace_name: "WALWorkspaceName",
})

rest_post_only_properties %i{
  wal_workspace_name
}
