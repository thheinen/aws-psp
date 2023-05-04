# Import API specifics
use "awscc_base"

resource_name :aws_osis_pipeline
provides :aws_osis_pipeline, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An OpenSearch Ingestion Service Data Prepper pipeline running Data Prepper.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :log_publishing_options, Hash,
         callbacks: {
           "Subproperty `IsLoggingEnabled` is not a Boolean" => lambda { |v| v[:IsLoggingEnabled].is_a? Boolean },
           "Subproperty `CloudWatchLogDestination` is not a Object" => lambda { |v| v[:CloudWatchLogDestination].is_a? Object },
         },
         description: ""

property :max_units, Integer,
         required: true,
         callbacks: {
           "max_units is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The maximum pipeline capacity, in Ingestion Compute Units (ICUs).
         DESCRIPTION

property :min_units, Integer,
         required: true,
         callbacks: {
           "min_units is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The minimum pipeline capacity, in Ingestion Compute Units (ICUs).
         DESCRIPTION

property :pipeline_configuration_body, String,
         required: true,
         callbacks: {
           "pipeline_configuration_body is not a String" => lambda { |v| v.is_a? String },
           "pipeline_configuration_body needs to be 1..12000 characters" => lambda { |v| v.length >= 1 && v.length <= 12000 },
         },
         description: <<~'DESCRIPTION'
           The Data Prepper pipeline configuration in YAML format.
         DESCRIPTION

property :pipeline_name, String,
         required: true,
         callbacks: {
           "pipeline_name is not a String" => lambda { |v| v.is_a? String },
           "pipeline_name needs to be 3..28 characters" => lambda { |v| v.length >= 3 && v.length <= 28 },
           "pipeline_name must match pattern [a-z][a-z0-9\-]+" => lambda { |v| v =~ Regexp.new("/[a-z][a-z0-9\-]+/") },
         },
         description: <<~'DESCRIPTION'
           Name of the OpenSearch Ingestion Service pipeline to create. Pipeline names are unique across the pipelines owned by an account within an AWS Region.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :vpc_options, Hash,
         callbacks: {
           "Subproperty `SecurityGroupIds` is not a Array" => lambda { |v| v[:SecurityGroupIds].is_a? Array },
           "Subproperty `SubnetIds` is not a Array" => lambda { |v| v[:SubnetIds].is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::OSIS::Pipeline"
rest_api_document "/AWS::OSIS::Pipeline"

rest_property_map({
  log_publishing_options:      "LogPublishingOptions",
  max_units:                   "MaxUnits",
  min_units:                   "MinUnits",
  pipeline_configuration_body: "PipelineConfigurationBody",
  pipeline_name:               "PipelineName",
  tags:                        "Tags",
  vpc_options:                 "VpcOptions",
})

rest_post_only_properties %i{
  pipeline_name
}
