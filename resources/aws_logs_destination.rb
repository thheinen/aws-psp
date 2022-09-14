# Import API specifics
use "awscc_base"

resource_name :aws_logs_destination
provides :aws_logs_destination, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::Logs::Destination resource specifies a CloudWatch Logs destination. A destination encapsulates a physical resource (such as an Amazon Kinesis data stream) and enables you to subscribe that resource to a stream of log events.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :destination_name, String,
         required: true,
         callbacks: {
           "destination_name is not a String" => lambda { |v| v.is_a? String },
           "destination_name needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
           "destination_name must match pattern ^[^:*]{1,512}$" => lambda { |v| v =~ Regexp.new("/^[^:*]{1,512}$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the destination resource
         DESCRIPTION

property :destination_policy, String,
         callbacks: {
           "destination_policy is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           An IAM policy document that governs which AWS accounts can create subscription filters against this destination.
         DESCRIPTION

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ARN of an IAM role that permits CloudWatch Logs to send data to the specified AWS resource
         DESCRIPTION

property :target_arn, String,
         required: true,
         callbacks: {
           "target_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ARN of the physical target where the log events are delivered (for example, a Kinesis stream)
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Logs::Destination"
rest_api_document "/AWS::Logs::Destination"

rest_property_map({
  destination_name:   "DestinationName",
  destination_policy: "DestinationPolicy",
  role_arn:           "RoleArn",
  target_arn:         "TargetArn",
})

rest_post_only_properties %i{
  destination_name
}
