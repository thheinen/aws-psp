# Import API specifics
use "awscc_base"

resource_name :aws_appflow_connector
provides :aws_appflow_connector, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::AppFlow::Connector
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :connector_label, String,
         callbacks: {
           "connector_label is not a String" => lambda { |v| v.is_a? String },
           "connector_label must match pattern [a-zA-Z0-9][\w!@#.-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9][\w!@#.-]+/") },
         },
         description: <<~'DESCRIPTION'
           The name of the connector. The name is unique for each ConnectorRegistration in your AWS account.
         DESCRIPTION

property :connector_provisioning_config, Hash,
         required: true,
         description: <<~'DESCRIPTION'
           Contains information about the configuration of the connector being registered.
         DESCRIPTION

property :connector_provisioning_type, String,
         required: true,
         callbacks: {
           "connector_provisioning_type is not a String" => lambda { |v| v.is_a? String },
           "connector_provisioning_type needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "connector_provisioning_type must match pattern [a-zA-Z0-9][\w!@#.-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9][\w!@#.-]+/") },
         },
         description: <<~'DESCRIPTION'
           The provisioning type of the connector. Currently the only supported value is LAMBDA.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description must match pattern [\s\w/!@#+=.-]*" => lambda { |v| v =~ Regexp.new("/[\s\w/!@#+=.-]*/") },
         },
         description: <<~'DESCRIPTION'
           A description about the connector that's being registered.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::AppFlow::Connector"
rest_api_document "/AWS::AppFlow::Connector"

rest_property_map({
  connector_label:               "ConnectorLabel",
  connector_provisioning_config: "ConnectorProvisioningConfig",
  connector_provisioning_type:   "ConnectorProvisioningType",
  description:                   "Description",
})

rest_post_only_properties %i{
  connector_label
}
