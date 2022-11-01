# Import API specifics
use "awscc_base"

resource_name :aws_mwaa_environment
provides :aws_mwaa_environment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::MWAA::Environment
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :airflow_configuration_options, Hash,
         callbacks: {
           "airflow_configuration_options is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           Key/value pairs representing Airflow configuration variables.
      Keys are prefixed by their section:
            [core]
      dags_folder={AIRFLOW_HOME}/dags
            Would be represented as
            "core.dags_folder": "{AIRFLOW_HOME}/dags"
         DESCRIPTION

property :airflow_version, Hash,
         callbacks: {
           "airflow_version is not a String" => lambda { |v| v.is_a? String },
           "airflow_version must match pattern ^[0-9a-z.]+$" => lambda { |v| v =~ Regexp.new("/^[0-9a-z.]+$/") },
         },
         description: ""

property :dag_s3_path, Hash,
         callbacks: {
           "dag_s3_path is not a String" => lambda { |v| v.is_a? String },
           "dag_s3_path must match pattern .*" => lambda { |v| v =~ Regexp.new("/.*/") },
         },
         description: ""

property :environment_class, Hash,
         callbacks: {
           "environment_class is not a String" => lambda { |v| v.is_a? String },
           "environment_class needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: ""

property :execution_role_arn, Hash,
         callbacks: {
           "execution_role_arn is not a String" => lambda { |v| v.is_a? String },
           "execution_role_arn must match pattern ^arn:(aws|aws-us-gov|aws-cn|aws-iso|aws-iso-b)(-[a-z]+)?:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$" => lambda { |v| v =~ Regexp.new("/^arn:(aws|aws-us-gov|aws-cn|aws-iso|aws-iso-b)(-[a-z]+)?:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$/") },
         },
         description: ""

property :kms_key, Hash,
         callbacks: {
           "kms_key is not a String" => lambda { |v| v.is_a? String },
           "kms_key must match pattern ^(((arn:(aws|aws-us-gov|aws-cn|aws-iso|aws-iso-b)(-[a-z]+)?:kms:[a-z]{2}-[a-z]+-\d:\d+:)?key\/)?[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}|(arn:(aws|aws-us-gov|aws-cn|aws-iso|aws-iso-b):kms:[a-z]{2}-[a-z]+-\d:\d+:)?alias/.+)$" => lambda { |v| v =~ Regexp.new("/^(((arn:(aws|aws-us-gov|aws-cn|aws-iso|aws-iso-b)(-[a-z]+)?:kms:[a-z]{2}-[a-z]+-\d:\d+:)?key\/)?[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}|(arn:(aws|aws-us-gov|aws-cn|aws-iso|aws-iso-b):kms:[a-z]{2}-[a-z]+-\d:\d+:)?alias/.+)$/") },
         },
         description: ""

property :logging_configuration, Hash,
         description: ""

property :max_workers, Hash,
         callbacks: {
           "max_workers is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :min_workers, Hash,
         callbacks: {
           "min_workers is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :name, Hash,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..80 characters" => lambda { |v| v.length >= 1 && v.length <= 80 },
           "name must match pattern ^[a-zA-Z][0-9a-zA-Z\-_]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z][0-9a-zA-Z\-_]*$/") },
         },
         description: ""

property :network_configuration, Hash,
         callbacks: {
           "Subproperty `SubnetIds` is not a Array" => lambda { |v| v[:SubnetIds].is_a? Array },
           "Subproperty `SecurityGroupIds` is not a Array" => lambda { |v| v[:SecurityGroupIds].is_a? Array },
         },
         description: ""

property :plugins_s3_object_version, Hash,
         callbacks: {
           "plugins_s3_object_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :plugins_s3_path, Hash,
         callbacks: {
           "plugins_s3_path is not a String" => lambda { |v| v.is_a? String },
           "plugins_s3_path must match pattern .*" => lambda { |v| v =~ Regexp.new("/.*/") },
         },
         description: ""

property :requirements_s3_object_version, Hash,
         callbacks: {
           "requirements_s3_object_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :requirements_s3_path, Hash,
         callbacks: {
           "requirements_s3_path is not a String" => lambda { |v| v.is_a? String },
           "requirements_s3_path must match pattern .*" => lambda { |v| v =~ Regexp.new("/.*/") },
         },
         description: ""

property :schedulers, Hash,
         callbacks: {
           "schedulers is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :source_bucket_arn, Hash,
         callbacks: {
           "source_bucket_arn is not a String" => lambda { |v| v.is_a? String },
           "source_bucket_arn needs to be 1..1224 characters" => lambda { |v| v.length >= 1 && v.length <= 1224 },
           "source_bucket_arn must match pattern ^arn:(aws|aws-us-gov|aws-cn|aws-iso|aws-iso-b)(-[a-z]+)?:s3:::[a-z0-9.\-]+$" => lambda { |v| v =~ Regexp.new("/^arn:(aws|aws-us-gov|aws-cn|aws-iso|aws-iso-b)(-[a-z]+)?:s3:::[a-z0-9.\-]+$/") },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           A map of tags for the environment.
         DESCRIPTION

property :webserver_access_mode, Hash,
         callbacks: {
           "webserver_access_mode is not a String" => lambda { |v| v.is_a? String },
           "webserver_access_modeis not one of `PRIVATE_ONLY`, `PUBLIC_ONLY`" => lambda { |v| %w{PRIVATE_ONLY PUBLIC_ONLY}.include? v },
         },
         description: ""

property :weekly_maintenance_window_start, Hash,
         callbacks: {
           "weekly_maintenance_window_start is not a String" => lambda { |v| v.is_a? String },
           "weekly_maintenance_window_start must match pattern (MON|TUE|WED|THU|FRI|SAT|SUN):([01]\d|2[0-3]):(00|30)" => lambda { |v| v =~ Regexp.new("/(MON|TUE|WED|THU|FRI|SAT|SUN):([01]\d|2[0-3]):(00|30)/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::MWAA::Environment"
rest_api_document "/AWS::MWAA::Environment"

rest_property_map({
  airflow_configuration_options:   "AirflowConfigurationOptions",
  airflow_version:                 "AirflowVersion",
  dag_s3_path:                     "DagS3Path",
  environment_class:               "EnvironmentClass",
  execution_role_arn:              "ExecutionRoleArn",
  kms_key:                         "KmsKey",
  logging_configuration:           "LoggingConfiguration",
  max_workers:                     "MaxWorkers",
  min_workers:                     "MinWorkers",
  name:                            "Name",
  network_configuration:           "NetworkConfiguration",
  plugins_s3_object_version:       "PluginsS3ObjectVersion",
  plugins_s3_path:                 "PluginsS3Path",
  requirements_s3_object_version:  "RequirementsS3ObjectVersion",
  requirements_s3_path:            "RequirementsS3Path",
  schedulers:                      "Schedulers",
  source_bucket_arn:               "SourceBucketArn",
  tags:                            "Tags",
  webserver_access_mode:           "WebserverAccessMode",
  weekly_maintenance_window_start: "WeeklyMaintenanceWindowStart",
})

rest_post_only_properties %i{
  kms_key name network_configuration/subnet_ids
}
