# Import API specifics
use "awscc_base"

resource_name :aws_iot_topic_rule_destination
provides :aws_iot_topic_rule_destination, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IoT::TopicRuleDestination
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :http_url_properties, Hash,
         callbacks: {
           "Subproperty `ConfirmationUrl` is not a String" => lambda { |v| v[:ConfirmationUrl].is_a? String },
         },
         description: "HTTP URL destination properties."

property :status, Hash,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
           "statusis not one of `ENABLED`, `IN_PROGRESS`, `DISABLED`" => lambda { |v| %w{ENABLED IN_PROGRESS DISABLED}.include? v },
         },
         description: "The status of the TopicRuleDestination."

property :vpc_properties, Hash,
         callbacks: {
           "Subproperty `SubnetIds` is not a Array" => lambda { |v| v[:SubnetIds].is_a? Array },
           "Subproperty `SecurityGroups` is not a Array" => lambda { |v| v[:SecurityGroups].is_a? Array },
           "Subproperty `VpcId` is not a String" => lambda { |v| v[:VpcId].is_a? String },
           "Subproperty `RoleArn` is not a String" => lambda { |v| v[:RoleArn].is_a? String },
           "Subproperty `RoleArn`is not a valid ARN" => lambda { |v| v[:RoleArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: "VPC destination properties."

# API URLs and mappings
rest_api_collection "/AWS::IoT::TopicRuleDestination"
rest_api_document "/AWS::IoT::TopicRuleDestination"

rest_property_map({
  http_url_properties: "HttpUrlProperties",
  status:              "Status",
  vpc_properties:      "VpcProperties",
})

rest_post_only_properties %i{
  http_url_properties vpc_properties
}
