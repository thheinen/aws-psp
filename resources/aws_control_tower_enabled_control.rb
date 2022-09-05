# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_control_tower_enabled_control
provides :aws_control_tower_enabled_control, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Enables a control on a specified target.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :control_identifier, String,
         required: true,
         callbacks: {
           "control_identifier is not a String" => lambda { |v| v.is_a? String },
           "control_identifier needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "control_identifier must match pattern ^arn:aws[0-9a-zA-Z_\-:\/]+$" => lambda { |v| v =~ Regexp.new("/^arn:aws[0-9a-zA-Z_\-:\/]+$/") },
         },
         description: <<~'DESCRIPTION'
           Arn of the control.
         DESCRIPTION

property :target_identifier, String,
         required: true,
         callbacks: {
           "target_identifier is not a String" => lambda { |v| v.is_a? String },
           "target_identifier needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "target_identifier must match pattern ^arn:aws[0-9a-zA-Z_\-:\/]+$" => lambda { |v| v =~ Regexp.new("/^arn:aws[0-9a-zA-Z_\-:\/]+$/") },
         },
         description: <<~'DESCRIPTION'
           Arn for Organizational unit to which the control needs to be applied
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ControlTower::EnabledControl"
rest_api_document "/AWS::ControlTower::EnabledControl"

rest_property_map({
  control_identifier: "ControlIdentifier",
  target_identifier:  "TargetIdentifier",
})

rest_post_only_properties %i{
  control_identifier target_identifier
}
