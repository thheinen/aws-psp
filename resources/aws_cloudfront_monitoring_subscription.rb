# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_cloudfront_monitoring_subscription
provides :aws_cloudfront_monitoring_subscription, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::CloudFront::MonitoringSubscription
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :distribution_id, String,
         required: true,
         callbacks: {
           "distribution_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :monitoring_subscription, Hash,
         required: true,
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::CloudFront::MonitoringSubscription"
rest_api_document "/AWS::CloudFront::MonitoringSubscription"

rest_property_map({
  distribution_id:         "DistributionId",
  monitoring_subscription: "MonitoringSubscription",
})

rest_post_only_properties %i{
  distribution_id
}
