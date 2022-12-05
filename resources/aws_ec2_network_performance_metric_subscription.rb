# Import API specifics
use "awscc_base"

resource_name :aws_ec2_network_performance_metric_subscription
provides :aws_ec2_network_performance_metric_subscription, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An example resource schema demonstrating some basic constructs and validation rules.
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
           The destination is a mandatory element for the metric subscription.
         DESCRIPTION

property :metric, String,
         required: true,
         callbacks: {
           "metric is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The metric type for the metric subscription.
         DESCRIPTION

property :source, String,
         required: true,
         callbacks: {
           "source is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The source is a mandatory element for the metric subscription.
         DESCRIPTION

property :statistic, String,
         required: true,
         callbacks: {
           "statistic is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The statistic type for the metric subscription.
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
