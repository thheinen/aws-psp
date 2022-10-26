# Import API specifics
use "awscc_base"

resource_name :aws_quicksight_data_source
provides :aws_quicksight_data_source, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of the AWS::QuickSight::DataSource Resource Type.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :alternate_data_source_parameters, Array,
         callbacks: {
           "alternate_data_source_parameters is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           <p>A set of alternate data source parameters that you want to share for the credentials
      stored with this data source. The credentials are applied in tandem with the data source
      parameters when you copy a data source by using a create or update request. The API
      operation compares the <code>DataSourceParameters</code> structure that's in the request
      with the structures in the <code>AlternateDataSourceParameters</code> allow list. If the
      structures are an exact match, the request is allowed to use the credentials from this
      existing data source. If the <code>AlternateDataSourceParameters</code> list is null,
      the <code>Credentials</code> originally used with this <code>DataSourceParameters</code>
      are automatically allowed.</p>
         DESCRIPTION

property :aws_account_id, String,
         callbacks: {
           "aws_account_id is not a String" => lambda { |v| v.is_a? String },
           "aws_account_id needs to be 12..12 characters" => lambda { |v| v.length >= 12 && v.length <= 12 },
           "aws_account_id must match pattern ^[0-9]{12}$" => lambda { |v| v =~ Regexp.new("/^[0-9]{12}$/") },
         },
         description: ""

property :credentials, Hash,
         callbacks: {
           "Subproperty `CopySourceArn` is not a String" => lambda { |v| v[:CopySourceArn].is_a? String },
           "Subproperty `CopySourceArn` must match pattern ^arn:[-a-z0-9]*:quicksight:[-a-z0-9]*:[0-9]{12}:datasource/.+" => lambda { |v| v[:CopySourceArn] =~ Regexp.new("/^arn:[-a-z0-9]*:quicksight:[-a-z0-9]*:[0-9]{12}:datasource/.+/") },
           "Subproperty `CopySourceArn`is not a valid ARN" => lambda { |v| v[:CopySourceArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `SecretArn` is not a String" => lambda { |v| v[:SecretArn].is_a? String },
           "Subproperty `SecretArn` needs to be 1..2048 characters" => lambda { |v| v[:SecretArn].length >= 1 && v[:SecretArn].length <= 2048 },
           "Subproperty `SecretArn` must match pattern ^arn:[-a-z0-9]*:secretsmanager:[-a-z0-9]*:[0-9]{12}:secret:.+" => lambda { |v| v[:SecretArn] =~ Regexp.new("/^arn:[-a-z0-9]*:secretsmanager:[-a-z0-9]*:[0-9]{12}:secret:.+/") },
           "Subproperty `SecretArn`is not a valid ARN" => lambda { |v| v[:SecretArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :data_source_id, String,
         callbacks: {
           "data_source_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :data_source_parameters, Hash,
         description: ""

property :error_info, Hash,
         callbacks: {
           "Subproperty `Message` is not a String" => lambda { |v| v[:Message].is_a? String },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
         },
         description: <<~'DESCRIPTION'
           <p>A display name for the data source.</p>
         DESCRIPTION

property :permissions, Array,
         callbacks: {
           "permissions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           <p>A list of resource permissions on the data source.</p>
         DESCRIPTION

property :ssl_properties, Hash,
         callbacks: {
           "Subproperty `DisableSsl` is not a Boolean" => lambda { |v| v[:DisableSsl].is_a? Boolean },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           <p>Contains a map of the key-value pairs for the resource tag or tags assigned to the data source.</p>
         DESCRIPTION

property :type, Hash,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `ADOBE_ANALYTICS`, `AMAZON_ELASTICSEARCH`, `AMAZON_OPENSEARCH`, `ATHENA`, `AURORA`, `AURORA_POSTGRESQL`, `AWS_IOT_ANALYTICS`, `GITHUB`, `JIRA`, `MARIADB`, `MYSQL`, `ORACLE`, `POSTGRESQL`, `PRESTO`, `REDSHIFT`, `S3`, `SALESFORCE`, `SERVICENOW`, `SNOWFLAKE`, `SPARK`, `SQLSERVER`, `TERADATA`, `TWITTER`, `TIMESTREAM`" => lambda { |v| %w{ADOBE_ANALYTICS AMAZON_ELASTICSEARCH AMAZON_OPENSEARCH ATHENA AURORA AURORA_POSTGRESQL AWS_IOT_ANALYTICS GITHUB JIRA MARIADB MYSQL ORACLE POSTGRESQL PRESTO REDSHIFT S3 SALESFORCE SERVICENOW SNOWFLAKE SPARK SQLSERVER TERADATA TWITTER TIMESTREAM}.include? v },
         },
         description: ""

property :vpc_connection_properties, Hash,
         callbacks: {
           "Subproperty `VpcConnectionArn` is not a String" => lambda { |v| v[:VpcConnectionArn].is_a? String },
           "Subproperty `VpcConnectionArn`is not a valid ARN" => lambda { |v| v[:VpcConnectionArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::QuickSight::DataSource"
rest_api_document "/AWS::QuickSight::DataSource"

rest_property_map({
  alternate_data_source_parameters: "AlternateDataSourceParameters",
  aws_account_id:                   "AwsAccountId",
  credentials:                      "Credentials",
  data_source_id:                   "DataSourceId",
  data_source_parameters:           "DataSourceParameters",
  error_info:                       "ErrorInfo",
  name:                             "Name",
  permissions:                      "Permissions",
  ssl_properties:                   "SslProperties",
  tags:                             "Tags",
  type:                             "Type",
  vpc_connection_properties:        "VpcConnectionProperties",
})

rest_post_only_properties %i{
  aws_account_id data_source_id type
}
