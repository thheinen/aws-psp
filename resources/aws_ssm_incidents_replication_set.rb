# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ssm_incidents_replication_set
provides :aws_ssm_incidents_replication_set, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource type definition for AWS::SSMIncidents::ReplicationSet
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :deletion_protected, Hash,
         callbacks: {
           "deletion_protected is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :regions, Hash,
         required: true,
         callbacks: {
           "regions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The ReplicationSet configuration.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SSMIncidents::ReplicationSet"
rest_api_document "/AWS::SSMIncidents::ReplicationSet"

rest_property_map({
  deletion_protected: "DeletionProtected",
  regions:            "Regions",
})

