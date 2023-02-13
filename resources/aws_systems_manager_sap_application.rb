# Import API specifics
use "awscc_base"

resource_name :aws_systems_manager_sap_application
provides :aws_systems_manager_sap_application, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::SystemsManagerSAP::Application
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :application_id, String,
         required: true,
         callbacks: {
           "application_id is not a String" => lambda { |v| v.is_a? String },
           "application_id must match pattern [\w\d]{1,50}" => lambda { |v| v =~ Regexp.new("/[\w\d]{1,50}/") },
         },
         description: ""

property :application_type, String,
         required: true,
         callbacks: {
           "application_type is not a String" => lambda { |v| v.is_a? String },
           "application_typeis not one of `HANA`" => lambda { |v| %w{HANA}.include? v },
         },
         description: ""

property :credentials, Array,
         callbacks: {
           "credentials is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :instances, Array,
         callbacks: {
           "instances is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :sap_instance_number, String,
         callbacks: {
           "sap_instance_number is not a String" => lambda { |v| v.is_a? String },
           "sap_instance_number must match pattern [0-9]{2}" => lambda { |v| v =~ Regexp.new("/[0-9]{2}/") },
         },
         description: ""

property :sid, String,
         callbacks: {
           "sid is not a String" => lambda { |v| v.is_a? String },
           "sid must match pattern [A-Z][A-Z0-9]{2}" => lambda { |v| v =~ Regexp.new("/[A-Z][A-Z0-9]{2}/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags of a SystemsManagerSAP application.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SystemsManagerSAP::Application"
rest_api_document "/AWS::SystemsManagerSAP::Application"

rest_property_map({
  application_id:      "ApplicationId",
  application_type:    "ApplicationType",
  credentials:         "Credentials",
  instances:           "Instances",
  sap_instance_number: "SapInstanceNumber",
  sid:                 "Sid",
  tags:                "Tags",
})

rest_post_only_properties %i{
  credentials instances sap_instance_number sid
}
