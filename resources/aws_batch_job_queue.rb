# Import API specifics
use "awscc_base"

resource_name :aws_batch_job_queue
provides :aws_batch_job_queue, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Batch::JobQueue
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :compute_environment_order, Array,
         required: true,
         callbacks: {
           "compute_environment_order is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :job_queue_name, String,
         callbacks: {
           "job_queue_name is not a String" => lambda { |v| v.is_a? String },
           "job_queue_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
         },
         description: ""

property :priority, Integer,
         required: true,
         callbacks: {
           "priority is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :scheduling_policy_arn, Hash,
         callbacks: {
           "scheduling_policy_arn is not a String" => lambda { |v| v.is_a? String },
           "scheduling_policy_arn must match pattern arn:[a-z0-9-\.]{1,63}:[a-z0-9-\.]{0,63}:[a-z0-9-\.]{0,63}:[a-z0-9-\.]{0,63}:[^/].{0,1023}" => lambda { |v| v =~ Regexp.new("/arn:[a-z0-9-\.]{1,63}:[a-z0-9-\.]{0,63}:[a-z0-9-\.]{0,63}:[a-z0-9-\.]{0,63}:[^/].{0,1023}/") },
         },
         description: ""

property :state, String,
         callbacks: {
           "state is not a String" => lambda { |v| v.is_a? String },
           "stateis not one of `DISABLED`, `ENABLED`" => lambda { |v| %w{DISABLED ENABLED}.include? v },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           A key-value pair to associate with a resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Batch::JobQueue"
rest_api_document "/AWS::Batch::JobQueue"

rest_property_map({
  compute_environment_order: "ComputeEnvironmentOrder",
  job_queue_name:            "JobQueueName",
  priority:                  "Priority",
  scheduling_policy_arn:     "SchedulingPolicyArn",
  state:                     "State",
  tags:                      "Tags",
})

rest_post_only_properties %i{
  job_queue_name tags
}
