# Import API specifics
use "awscc_base"

resource_name :aws_kinesis_analytics_v2_application
provides :aws_kinesis_analytics_v2_application, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Creates an Amazon Kinesis Data Analytics application. For information about creating a Kinesis Data Analytics application, see [Creating an Application](https://docs.aws.amazon.com/kinesisanalytics/latest/java/getting-started.html).
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :application_configuration, Hash,
         description: <<~'DESCRIPTION'
           Use this parameter to configure the application.
         DESCRIPTION

property :application_description, String,
         callbacks: {
           "application_description is not a String" => lambda { |v| v.is_a? String },
           "application_description needs to be 0..1024 characters" => lambda { |v| v.length >= 0 && v.length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           The description of the application.
         DESCRIPTION

property :application_maintenance_configuration, Hash,
         callbacks: {
           "Subproperty `ApplicationMaintenanceWindowStartTime` is not a String" => lambda { |v| v[:ApplicationMaintenanceWindowStartTime].is_a? String },
           "Subproperty `ApplicationMaintenanceWindowStartTime` must match pattern ^([01][0-9]|2[0-3]):[0-5][0-9]$" => lambda { |v| v[:ApplicationMaintenanceWindowStartTime] =~ Regexp.new("/^([01][0-9]|2[0-3]):[0-5][0-9]$/") },
         },
         description: <<~'DESCRIPTION'
           Used to configure start of maintenance window.
         DESCRIPTION

property :application_mode, String,
         callbacks: {
           "application_mode is not a String" => lambda { |v| v.is_a? String },
           "application_modeis not one of `INTERACTIVE`, `STREAMING`" => lambda { |v| %w{INTERACTIVE STREAMING}.include? v },
         },
         description: <<~'DESCRIPTION'
           To create a Kinesis Data Analytics Studio notebook, you must set the mode to `INTERACTIVE`. However, for a Kinesis Data Analytics for Apache Flink application, the mode is optional.
         DESCRIPTION

property :application_name, String,
         callbacks: {
           "application_name is not a String" => lambda { |v| v.is_a? String },
           "application_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "application_name must match pattern ^[a-zA-Z0-9_.-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_.-]+$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the application.
         DESCRIPTION

property :run_configuration, Hash,
         description: <<~'DESCRIPTION'
           Specifies run configuration (start parameters) of a Kinesis Data Analytics application. Evaluated on update for RUNNING applications an only.
         DESCRIPTION

property :runtime_environment, String,
         required: true,
         callbacks: {
           "runtime_environment is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The runtime environment for the application.
         DESCRIPTION

property :service_execution_role, Hash,
         required: true,
         callbacks: {
           "service_execution_role is not a String" => lambda { |v| v.is_a? String },
           "service_execution_role needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
           "service_execution_role must match pattern ^arn:.*$" => lambda { |v| v =~ Regexp.new("/^arn:.*$/") },
         },
         description: <<~'DESCRIPTION'
           Specifies the IAM role that the application uses to access external resources.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of one or more tags to assign to the application. A tag is a key-value pair that identifies an application. Note that the maximum number of application tags includes system tags. The maximum number of user-defined application tags is 50.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::KinesisAnalyticsV2::Application"
rest_api_document "/AWS::KinesisAnalyticsV2::Application"

rest_property_map({
  application_configuration:             "ApplicationConfiguration",
  application_description:               "ApplicationDescription",
  application_maintenance_configuration: "ApplicationMaintenanceConfiguration",
  application_mode:                      "ApplicationMode",
  application_name:                      "ApplicationName",
  run_configuration:                     "RunConfiguration",
  runtime_environment:                   "RuntimeEnvironment",
  service_execution_role:                "ServiceExecutionRole",
  tags:                                  "Tags",
})

rest_post_only_properties %i{
  application_mode application_name runtime_environment
}
