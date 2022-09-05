# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_redshift_event_subscription
provides :aws_redshift_event_subscription, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The `AWS::Redshift::EventSubscription` resource creates an Amazon Redshift Event Subscription.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :enabled, [TrueClass, FalseClass],
         callbacks: {
           "enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A boolean value; set to true to activate the subscription, and set to false to create the subscription but not activate it.
         DESCRIPTION

property :event_categories, Array,
         callbacks: {
           "event_categories is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Specifies the Amazon Redshift event categories to be published by the event notification subscription.
         DESCRIPTION

property :severity, String,
         callbacks: {
           "severity is not a String" => lambda { |v| v.is_a? String },
           "severityis not one of `ERROR`, `INFO`" => lambda { |v| %w{ERROR INFO}.include? v },
         },
         description: <<~'DESCRIPTION'
           Specifies the Amazon Redshift event severity to be published by the event notification subscription.
         DESCRIPTION

property :sns_topic_arn, String,
         callbacks: {
           "sns_topic_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the Amazon SNS topic used to transmit the event notifications.
         DESCRIPTION

property :source_ids, Array,
         callbacks: {
           "source_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of one or more identifiers of Amazon Redshift source objects.
         DESCRIPTION

property :source_type, String,
         callbacks: {
           "source_type is not a String" => lambda { |v| v.is_a? String },
           "source_typeis not one of `cluster`, `cluster-parameter-group`, `cluster-security-group`, `cluster-snapshot`, `scheduled-action`" => lambda { |v| %w{cluster cluster-parameter-group cluster-security-group cluster-snapshot scheduled-action}.include? v },
         },
         description: <<~'DESCRIPTION'
           The type of source that will be generating the events.
         DESCRIPTION

property :subscription_name, String,
         required: true,
         callbacks: {
           "subscription_name is not a String" => lambda { |v| v.is_a? String },
           "subscription_name must match pattern ^(?=^[a-z][a-z0-9]*(-[a-z0-9]+)*$).{1,255}$" => lambda { |v| v =~ Regexp.new("/^(?=^[a-z][a-z0-9]*(-[a-z0-9]+)*$).{1,255}$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the Amazon Redshift event notification subscription
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Redshift::EventSubscription"
rest_api_document "/AWS::Redshift::EventSubscription"

rest_property_map({
  enabled:           "Enabled",
  event_categories:  "EventCategories",
  severity:          "Severity",
  sns_topic_arn:     "SnsTopicArn",
  source_ids:        "SourceIds",
  source_type:       "SourceType",
  subscription_name: "SubscriptionName",
  tags:              "Tags",
})

rest_post_only_properties %i{
  subscription_name
}
