# Import API specifics
use "awscc_base"

resource_name :aws_ec2_flow_log
provides :aws_ec2_flow_log, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Specifies a VPC flow log, which enables you to capture IP traffic for a specific network interface, subnet, or VPC.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :deliver_cross_account_role, String,
         callbacks: {
           "deliver_cross_account_role is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ARN of the IAM role that allows Amazon EC2 to publish flow logs across accounts.
         DESCRIPTION

property :deliver_logs_permission_arn, String,
         callbacks: {
           "deliver_logs_permission_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ARN for the IAM role that permits Amazon EC2 to publish flow logs to a CloudWatch Logs log group in your account. If you specify LogDestinationType as s3 or kinesis-data-firehose, do not specify DeliverLogsPermissionArn or LogGroupName.
         DESCRIPTION

property :destination_options, Hash,
         callbacks: {
           "Subproperty `FileFormat` is not a String" => lambda { |v| v[:FileFormat].is_a? String },
           "Subproperty `FileFormat`is not one of `plain-text`, `parquet`" => lambda { |v| %w{plain-text parquet}.include? v[:FileFormat] },
           "Subproperty `HiveCompatiblePartitions` is not a Boolean" => lambda { |v| v[:HiveCompatiblePartitions].is_a? Boolean },
           "Subproperty `PerHourPartition` is not a Boolean" => lambda { |v| v[:PerHourPartition].is_a? Boolean },
         },
         description: ""

property :log_destination, String,
         callbacks: {
           "log_destination is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the destination to which the flow log data is to be published. Flow log data can be published to a CloudWatch Logs log group, an Amazon S3 bucket, or a Kinesis Firehose stream. The value specified for this parameter depends on the value specified for LogDestinationType.
         DESCRIPTION

property :log_destination_type, String,
         callbacks: {
           "log_destination_type is not a String" => lambda { |v| v.is_a? String },
           "log_destination_typeis not one of `cloud-watch-logs`, `s3`, `kinesis-data-firehose`" => lambda { |v| %w{cloud-watch-logs s3 kinesis-data-firehose}.include? v },
         },
         description: <<~'DESCRIPTION'
           Specifies the type of destination to which the flow log data is to be published. Flow log data can be published to CloudWatch Logs or Amazon S3.
         DESCRIPTION

property :log_format, String,
         callbacks: {
           "log_format is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The fields to include in the flow log record, in the order in which they should appear.
         DESCRIPTION

property :log_group_name, String,
         callbacks: {
           "log_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of a new or existing CloudWatch Logs log group where Amazon EC2 publishes your flow logs. If you specify LogDestinationType as s3 or kinesis-data-firehose, do not specify DeliverLogsPermissionArn or LogGroupName.
         DESCRIPTION

property :max_aggregation_interval, Integer,
         callbacks: {
           "max_aggregation_interval is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The maximum interval of time during which a flow of packets is captured and aggregated into a flow log record. You can specify 60 seconds (1 minute) or 600 seconds (10 minutes).
         DESCRIPTION

property :resource_id, String,
         required: true,
         callbacks: {
           "resource_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the subnet, network interface, or VPC for which you want to create a flow log.
         DESCRIPTION

property :resource_type, String,
         required: true,
         callbacks: {
           "resource_type is not a String" => lambda { |v| v.is_a? String },
           "resource_typeis not one of `NetworkInterface`, `Subnet`, `VPC`, `TransitGateway`, `TransitGatewayAttachment`" => lambda { |v| %w{NetworkInterface Subnet VPC TransitGateway TransitGatewayAttachment}.include? v },
         },
         description: <<~'DESCRIPTION'
           The type of resource for which to create the flow log. For example, if you specified a VPC ID for the ResourceId property, specify VPC for this property.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags to apply to the flow logs.
         DESCRIPTION

property :traffic_type, String,
         callbacks: {
           "traffic_type is not a String" => lambda { |v| v.is_a? String },
           "traffic_typeis not one of `ACCEPT`, `ALL`, `REJECT`" => lambda { |v| %w{ACCEPT ALL REJECT}.include? v },
         },
         description: <<~'DESCRIPTION'
           The type of traffic to log. You can log traffic that the resource accepts or rejects, or all traffic.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::FlowLog"
rest_api_document "/AWS::EC2::FlowLog"

rest_property_map({
  deliver_cross_account_role:  "DeliverCrossAccountRole",
  deliver_logs_permission_arn: "DeliverLogsPermissionArn",
  destination_options:         "DestinationOptions",
  log_destination:             "LogDestination",
  log_destination_type:        "LogDestinationType",
  log_format:                  "LogFormat",
  log_group_name:              "LogGroupName",
  max_aggregation_interval:    "MaxAggregationInterval",
  resource_id:                 "ResourceId",
  resource_type:               "ResourceType",
  tags:                        "Tags",
  traffic_type:                "TrafficType",
})

rest_post_only_properties %i{
  deliver_cross_account_role deliver_logs_permission_arn destination_options log_destination log_destination_type log_format log_group_name max_aggregation_interval resource_id resource_type traffic_type
}
