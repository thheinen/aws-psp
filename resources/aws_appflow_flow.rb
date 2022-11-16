# Import API specifics
use "awscc_base"

resource_name :aws_appflow_flow
provides :aws_appflow_flow, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::AppFlow::Flow.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description must match pattern [\w!@#\-.?,\s]*" => lambda { |v| v =~ Regexp.new("/[\w!@#\-.?,\s]*/") },
         },
         description: <<~'DESCRIPTION'
           Description of the flow.
         DESCRIPTION

property :destination_flow_config_list, Array,
         required: true,
         callbacks: {
           "destination_flow_config_list is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           List of Destination connectors of the flow.
         DESCRIPTION

property :flow_name, String,
         required: true,
         callbacks: {
           "flow_name is not a String" => lambda { |v| v.is_a? String },
           "flow_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "flow_name must match pattern [a-zA-Z0-9][\w!@#.-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9][\w!@#.-]+/") },
         },
         description: <<~'DESCRIPTION'
           Name of the flow.
         DESCRIPTION

property :kms_arn, String,
         callbacks: {
           "kms_arn is not a String" => lambda { |v| v.is_a? String },
           "kms_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "kms_arn must match pattern arn:aws:kms:.*:[0-9]+:.*" => lambda { |v| v =~ Regexp.new("/arn:aws:kms:.*:[0-9]+:.*/") },
         },
         description: <<~'DESCRIPTION'
           The ARN of the AWS Key Management Service (AWS KMS) key that's used to encrypt your function's environment variables. If it's not provided, AWS Lambda uses a default service key.
         DESCRIPTION

property :source_flow_config, Hash,
         required: true,
         description: <<~'DESCRIPTION'
           Configurations of Source connector of the flow.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           List of Tags.
         DESCRIPTION

property :tasks, Array,
         required: true,
         callbacks: {
           "tasks is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           List of tasks for the flow.
         DESCRIPTION

property :trigger_config, Hash,
         required: true,
         description: <<~'DESCRIPTION'
           Trigger settings of the flow.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::AppFlow::Flow"
rest_api_document "/AWS::AppFlow::Flow"

rest_property_map({
  description:                  "Description",
  destination_flow_config_list: "DestinationFlowConfigList",
  flow_name:                    "FlowName",
  kms_arn:                      "KMSArn",
  source_flow_config:           "SourceFlowConfig",
  tags:                         "Tags",
  tasks:                        "Tasks",
  trigger_config:               "TriggerConfig",
})

rest_post_only_properties %i{
  flow_name kms_arn
}
