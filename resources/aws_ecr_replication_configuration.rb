# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ecr_replication_configuration
provides :aws_ecr_replication_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::ECR::ReplicationConfiguration resource configures the replication destinations for an Amazon Elastic Container Registry (Amazon Private ECR). For more information, see https://docs.aws.amazon.com/AmazonECR/latest/userguide/replication.html
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :replication_configuration, Hash,
         required: true,
         callbacks: {
           "Subproperty `Rules` is not a Array" => lambda { |v| v[:Rules].is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ECR::ReplicationConfiguration"
rest_api_document "/AWS::ECR::ReplicationConfiguration"

rest_property_map({
  replication_configuration: "ReplicationConfiguration",
})

