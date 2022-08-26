# Import API specifics
use "awscc_base"

resource_name :aws_appflow_connector_profile
provides :aws_appflow_connector_profile, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::AppFlow::ConnectorProfile
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :connection_mode, String,
         required: true,
         callbacks: {
           "connection_mode is not a String" => lambda { |v| v.is_a? String },
           "connection_modeis not one of `Public`, `Private`" => lambda { |v| %w{Public Private}.include? v },
         },
         description: "Mode in which data transfer should be enabled. Private connection mode is currently enabled for Salesforce, Snowflake, Trendmicro and Singular"

property :connector_label, String,
         callbacks: {
           "connector_label is not a String" => lambda { |v| v.is_a? String },
           "connector_label must match pattern [\w!@#.-]+" => lambda { |v| v =~ Regexp.new("/[\w!@#.-]+/") },
         },
         description: "The label of the connector. The label is unique for each ConnectorRegistration in your AWS account. Only needed if calling for CUSTOMCONNECTOR connector type/."

property :connector_profile_config, Hash,
         description: "Connector specific configurations needed to create connector profile"

property :connector_profile_name, String,
         required: true,
         callbacks: {
           "connector_profile_name is not a String" => lambda { |v| v.is_a? String },
           "connector_profile_name must match pattern [\w/!@#+=.-]+" => lambda { |v| v =~ Regexp.new("/[\w/!@#+=.-]+/") },
         },
         description: "The maximum number of items to retrieve in a single batch."

property :connector_type, Hash,
         required: true,
         callbacks: {
           "connector_type is not a String" => lambda { |v| v.is_a? String },
           "connector_typeis not one of `Salesforce`, `Singular`, `Slack`, `Redshift`, `Marketo`, `Googleanalytics`, `Zendesk`, `Servicenow`, `SAPOData`, `Datadog`, `Trendmicro`, `Snowflake`, `Dynatrace`, `Infornexus`, `Amplitude`, `Veeva`, `CustomConnector`" => lambda { |v| %w{Salesforce Singular Slack Redshift Marketo Googleanalytics Zendesk Servicenow SAPOData Datadog Trendmicro Snowflake Dynatrace Infornexus Amplitude Veeva CustomConnector}.include? v },
         },
         description: "List of Saas providers that need connector profile to be created"

property :kms_arn, String,
         callbacks: {
           "kms_arn is not a String" => lambda { |v| v.is_a? String },
           "kms_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "kms_arn must match pattern arn:aws:kms:.*:[0-9]+:.*" => lambda { |v| v =~ Regexp.new("/arn:aws:kms:.*:[0-9]+:.*/") },
         },
         description: "The ARN of the AWS Key Management Service (AWS KMS) key that's used to encrypt your function's environment variables. If it's not provided, AWS Lambda uses a default service key."

# API URLs and mappings
rest_api_collection "/AWS::AppFlow::ConnectorProfile"
rest_api_document "/AWS::AppFlow::ConnectorProfile"

rest_property_map({
  connection_mode:          "ConnectionMode",
  connector_label:          "ConnectorLabel",
  connector_profile_config: "ConnectorProfileConfig",
  connector_profile_name:   "ConnectorProfileName",
  connector_type:           "ConnectorType",
  kms_arn:                  "KMSArn",
})

rest_post_only_properties %i{
  connector_profile_name connector_type kms_arn
}
