# Import API specifics
use "awscc_base"

resource_name :aws_ec2_network_performance_metric_subscription
provides :aws_ec2_network_performance_metric_subscription, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::NetworkPerformanceMetricSubscription
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :destination, String,
         required: true,
         callbacks: {
           "destination is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The target Region or Availability Zone for the metric to subscribe to.
         DESCRIPTION

property :metric, String,
         required: true,
         callbacks: {
           "metric is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The metric type to subscribe to.
         DESCRIPTION

property :source, String,
         required: true,
         callbacks: {
           "source is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The starting Region or Availability Zone for metric to subscribe to.
         DESCRIPTION

property :statistic, String,
         required: true,
         callbacks: {
           "statistic is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The statistic to subscribe to.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::NetworkPerformanceMetricSubscription"
rest_api_document "/AWS::EC2::NetworkPerformanceMetricSubscription"

rest_property_map({
  destination: "Destination",
  metric:      "Metric",
  source:      "Source",
  statistic:   "Statistic",
})

rest_post_only_properties %i{
  destination metric source statistic
}
