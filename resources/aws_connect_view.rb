# Import API specifics
use "awscc_base"

resource_name :aws_connect_view
provides :aws_connect_view, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Connect::View
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :actions, Array,
         required: true,
         callbacks: {
           "actions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The actions of the view in an array.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..4096 characters" => lambda { |v| v.length >= 0 && v.length <= 4096 },
           "description must match pattern ^([\p{L}\p{N}_.:\/=+\-@,]+[\p{L}\p{Z}\p{N}_.:\/=+\-@,]*)$" => lambda { |v| v =~ Regexp.new("/^([\p{L}\p{N}_.:\/=+\-@,]+[\p{L}\p{Z}\p{N}_.:\/=+\-@,]*)$/") },
         },
         description: <<~'DESCRIPTION'
           The description of the view.
         DESCRIPTION

property :instance_arn, String,
         required: true,
         callbacks: {
           "instance_arn is not a String" => lambda { |v| v.is_a? String },
           "instance_arn needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "instance_arn must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the instance.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
           "name must match pattern ^([\p{L}\p{N}_.:\/=+\-@]+[\p{L}\p{Z}\p{N}_.:\/=+\-@]*)$" => lambda { |v| v =~ Regexp.new("/^([\p{L}\p{N}_.:\/=+\-@]+[\p{L}\p{Z}\p{N}_.:\/=+\-@]*)$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the view.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           One or more tags.
         DESCRIPTION

property :template, Hash,
         required: true,
         callbacks: {
           "template is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The template of the view as JSON.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Connect::View"
rest_api_document "/AWS::Connect::View"

rest_property_map({
  actions:      "Actions",
  description:  "Description",
  instance_arn: "InstanceArn",
  name:         "Name",
  tags:         "Tags",
  template:     "Template",
})

