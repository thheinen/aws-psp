# Import API specifics
use "awscc_base"

resource_name :aws_customer_profiles_integration
provides :aws_customer_profiles_integration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The resource schema for creating an Amazon Connect Customer Profiles Integration.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :domain_name, String,
         required: true,
         callbacks: {
           "domain_name is not a String" => lambda { |v| v.is_a? String },
           "domain_name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "domain_name must match pattern ^[a-zA-Z0-9_-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_-]+$/") },
         },
         description: <<~'DESCRIPTION'
           The unique name of the domain.
         DESCRIPTION

property :flow_definition, Hash,
         callbacks: {
           "Subproperty `FlowName` is not a String" => lambda { |v| v[:FlowName].is_a? String },
           "Subproperty `FlowName` must match pattern [a-zA-Z0-9][\w!@#.-]+" => lambda { |v| v[:FlowName] =~ Regexp.new("/[a-zA-Z0-9][\w!@#.-]+/") },
           "Subproperty `Description` is not a String" => lambda { |v| v[:Description].is_a? String },
           "Subproperty `Description` must match pattern [\w!@#\-.?,\s]*" => lambda { |v| v[:Description] =~ Regexp.new("/[\w!@#\-.?,\s]*/") },
           "Subproperty `KmsArn` is not a String" => lambda { |v| v[:KmsArn].is_a? String },
           "Subproperty `KmsArn` needs to be 20..2048 characters" => lambda { |v| v[:KmsArn].length >= 20 && v[:KmsArn].length <= 2048 },
           "Subproperty `KmsArn` must match pattern arn:aws:kms:.*:[0-9]+:.*" => lambda { |v| v[:KmsArn] =~ Regexp.new("/arn:aws:kms:.*:[0-9]+:.*/") },
           "Subproperty `KmsArn`is not a valid ARN" => lambda { |v| v[:KmsArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `Tasks` is not a Array" => lambda { |v| v[:Tasks].is_a? Array },
         },
         description: ""

property :object_type_name, String,
         callbacks: {
           "object_type_name is not a String" => lambda { |v| v.is_a? String },
           "object_type_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "object_type_name must match pattern ^[a-zA-Z_][a-zA-Z_0-9-]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z_][a-zA-Z_0-9-]*$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the ObjectType defined for the 3rd party data in Profile Service
         DESCRIPTION

property :object_type_names, Array,
         callbacks: {
           "object_type_names is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The mapping between 3rd party event types and ObjectType names
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags (keys and values) associated with the integration
         DESCRIPTION

property :uri, String,
         callbacks: {
           "uri is not a String" => lambda { |v| v.is_a? String },
           "uri needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The URI of the S3 bucket or any other type of data source.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CustomerProfiles::Integration"
rest_api_document "/AWS::CustomerProfiles::Integration"

rest_property_map({
  domain_name:       "DomainName",
  flow_definition:   "FlowDefinition",
  object_type_name:  "ObjectTypeName",
  object_type_names: "ObjectTypeNames",
  tags:              "Tags",
  uri:               "Uri",
})

rest_post_only_properties %i{
  domain_name uri
}
