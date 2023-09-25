# Import API specifics
use "awscc_base"

resource_name :aws_connect_rule
provides :aws_connect_rule, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS:Connect::Rule
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :actions, Hash,
         required: true,
         description: <<~'DESCRIPTION'
           The list of actions that will be executed when a rule is triggered.
         DESCRIPTION

property :function, String,
         required: true,
         callbacks: {
           "function is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The conditions of a rule.
         DESCRIPTION

property :instance_arn, String,
         required: true,
         callbacks: {
           "instance_arn is not a String" => lambda { |v| v.is_a? String },
           "instance_arn must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the instance.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern ^[a-zA-Z0-9._-]{1,200}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9._-]{1,200}$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the rule.
         DESCRIPTION

property :publish_status, String,
         required: true,
         callbacks: {
           "publish_status is not a String" => lambda { |v| v.is_a? String },
           "publish_statusis not one of `DRAFT`, `PUBLISHED`" => lambda { |v| %w{DRAFT PUBLISHED}.include? v },
         },
         description: <<~'DESCRIPTION'
           The publish status of a rule, either draft or published.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           One or more tags.
         DESCRIPTION

property :trigger_event_source, Hash,
         required: true,
         callbacks: {
           "Subproperty `EventSourceName` is not a String" => lambda { |v| v[:EventSourceName].is_a? String },
           "Subproperty `EventSourceName`is not one of `OnContactEvaluationSubmit`, `OnPostCallAnalysisAvailable`, `OnRealTimeCallAnalysisAvailable`, `OnPostChatAnalysisAvailable`, `OnZendeskTicketCreate`, `OnZendeskTicketStatusUpdate`, `OnSalesforceCaseCreate`, `OnMetricDataUpdate`" => lambda { |v| %w{OnContactEvaluationSubmit OnPostCallAnalysisAvailable OnRealTimeCallAnalysisAvailable OnPostChatAnalysisAvailable OnZendeskTicketCreate OnZendeskTicketStatusUpdate OnSalesforceCaseCreate OnMetricDataUpdate}.include? v[:EventSourceName] },
           "Subproperty `IntegrationAssociationArn` is not a String" => lambda { |v| v[:IntegrationAssociationArn].is_a? String },
           "Subproperty `IntegrationAssociationArn` must match pattern ^$|arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*/integration-association/[-a-zA-Z0-9]*$" => lambda { |v| v[:IntegrationAssociationArn] =~ Regexp.new("/^$|arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*/integration-association/[-a-zA-Z0-9]*$/") },
           "Subproperty `IntegrationAssociationArn`is not a valid ARN" => lambda { |v| v[:IntegrationAssociationArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: <<~'DESCRIPTION'
           The event source that triggers the rule.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Connect::Rule"
rest_api_document "/AWS::Connect::Rule"

rest_property_map({
  actions:              "Actions",
  function:             "Function",
  instance_arn:         "InstanceArn",
  name:                 "Name",
  publish_status:       "PublishStatus",
  tags:                 "Tags",
  trigger_event_source: "TriggerEventSource",
})

rest_post_only_properties %i{
  instance_arn trigger_event_source
}
