# Import API specifics
use "awscc_base"

resource_name :aws_application_autoscaling_scalable_target
provides :aws_application_autoscaling_scalable_target, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApplicationAutoScaling::ScalableTarget
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :max_capacity, Integer,
         required: true,
         callbacks: {
           "max_capacity is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The maximum value that you plan to scale in to. When a scaling policy is in effect, Application Auto Scaling can scale in (contract) as needed to the minimum capacity limit in response to changing demand
         DESCRIPTION

property :min_capacity, Integer,
         required: true,
         callbacks: {
           "min_capacity is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The minimum value that you plan to scale in to. When a scaling policy is in effect, Application Auto Scaling can scale in (contract) as needed to the minimum capacity limit in response to changing demand
         DESCRIPTION

property :resource_id, String,
         required: true,
         callbacks: {
           "resource_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The identifier of the resource associated with the scalable target
         DESCRIPTION

property :role_arn, String,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specify the Amazon Resource Name (ARN) of an Identity and Access Management (IAM) role that allows Application Auto Scaling to modify the scalable target on your behalf.
         DESCRIPTION

property :scalable_dimension, String,
         required: true,
         callbacks: {
           "scalable_dimension is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The scalable dimension associated with the scalable target. This string consists of the service namespace, resource type, and scaling property
         DESCRIPTION

property :scheduled_actions, Array,
         callbacks: {
           "scheduled_actions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The scheduled actions for the scalable target. Duplicates aren't allowed.
         DESCRIPTION

property :service_namespace, String,
         required: true,
         callbacks: {
           "service_namespace is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The namespace of the AWS service that provides the resource, or a custom-resource
         DESCRIPTION

property :suspended_state, Hash,
         callbacks: {
           "Subproperty `ScheduledScalingSuspended` is not a Boolean" => lambda { |v| v[:ScheduledScalingSuspended].is_a? Boolean },
           "Subproperty `DynamicScalingOutSuspended` is not a Boolean" => lambda { |v| v[:DynamicScalingOutSuspended].is_a? Boolean },
           "Subproperty `DynamicScalingInSuspended` is not a Boolean" => lambda { |v| v[:DynamicScalingInSuspended].is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           An embedded object that contains attributes and attribute values that are used to suspend and resume automatic scaling. Setting the value of an attribute to true suspends the specified scaling activities. Setting it to false (default) resumes the specified scaling activities.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApplicationAutoScaling::ScalableTarget"
rest_api_document "/AWS::ApplicationAutoScaling::ScalableTarget"

rest_property_map({
  max_capacity:       "MaxCapacity",
  min_capacity:       "MinCapacity",
  resource_id:        "ResourceId",
  role_arn:           "RoleARN",
  scalable_dimension: "ScalableDimension",
  scheduled_actions:  "ScheduledActions",
  service_namespace:  "ServiceNamespace",
  suspended_state:    "SuspendedState",
})

rest_post_only_properties %i{
  resource_id scalable_dimension service_namespace
}
