# Import API specifics
use "awscc_base"

resource_name :aws_msk_batch_scram_secret
provides :aws_msk_batch_scram_secret, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::MSK::BatchScramSecret
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :cluster_arn, String,
         required: true,
         callbacks: {
           "cluster_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :secret_arn_list, Hash,
         callbacks: {
           "secret_arn_list is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::MSK::BatchScramSecret"
rest_api_document "/AWS::MSK::BatchScramSecret"

rest_property_map({
  cluster_arn:     "ClusterArn",
  secret_arn_list: "SecretArnList",
})

rest_post_only_properties %i{
  cluster_arn
}
