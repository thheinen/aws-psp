# Import API specifics
use "awscc_base"

resource_name :aws_iot_billing_group
provides :aws_iot_billing_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IoT::BillingGroup
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :billing_group_name, String,
         callbacks: {
           "billing_group_name is not a String" => lambda { |v| v.is_a? String },
           "billing_group_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "billing_group_name must match pattern [a-zA-Z0-9:_-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9:_-]+/") },
         },
         description: ""

property :billing_group_properties, Hash,
         callbacks: {
           "Subproperty `BillingGroupDescription` is not a String" => lambda { |v| v[:BillingGroupDescription].is_a? String },
           "Subproperty `BillingGroupDescription` must match pattern [\p{Graph}\x20]*" => lambda { |v| v[:BillingGroupDescription] =~ Regexp.new("/[\p{Graph}\x20]*/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoT::BillingGroup"
rest_api_document "/AWS::IoT::BillingGroup"

rest_property_map({
  billing_group_name:       "BillingGroupName",
  billing_group_properties: "BillingGroupProperties",
  tags:                     "Tags",
})

rest_post_only_properties %i{
  billing_group_name
}
