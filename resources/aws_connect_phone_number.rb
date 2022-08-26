# Import API specifics
use "awscc_base"

resource_name :aws_connect_phone_number
provides :aws_connect_phone_number, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Connect::PhoneNumber
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :country_code, String,
         required: true,
         callbacks: {
           "country_code is not a String" => lambda { |v| v.is_a? String },
           "country_code must match pattern ^[A-Z]{2}" => lambda { |v| v =~ Regexp.new("/^[A-Z]{2}/") },
         },
         description: "The phone number country code."

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..500 characters" => lambda { |v| v.length >= 1 && v.length <= 500 },
         },
         description: "The description of the phone number."

property :prefix, String,
         callbacks: {
           "prefix is not a String" => lambda { |v| v.is_a? String },
           "prefix must match pattern ^\+[0-9]{1,15}" => lambda { |v| v =~ Regexp.new("/^\+[0-9]{1,15}/") },
         },
         description: "The phone number prefix."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "One or more tags."

property :target_arn, String,
         required: true,
         callbacks: {
           "target_arn is not a String" => lambda { |v| v.is_a? String },
           "target_arn must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$/") },
         },
         description: "The ARN of the Amazon Connect instance the phone number is claimed to."

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "type must match pattern TOLL_FREE|DID" => lambda { |v| v =~ Regexp.new("/TOLL_FREE|DID/") },
         },
         description: "The phone number type, either TOLL_FREE or DID."

# API URLs and mappings
rest_api_collection "/AWS::Connect::PhoneNumber"
rest_api_document "/AWS::Connect::PhoneNumber"

rest_property_map({
  country_code: "CountryCode",
  description:  "Description",
  prefix:       "Prefix",
  tags:         "Tags",
  target_arn:   "TargetArn",
  type:         "Type",
})

rest_post_only_properties %i{
  country_code description prefix type
}
