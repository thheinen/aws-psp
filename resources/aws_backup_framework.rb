# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_backup_framework
provides :aws_backup_framework, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Contains detailed information about a framework. Frameworks contain controls, which evaluate and report on your backup events and resources. Frameworks generate daily compliance results.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :framework_controls, Array,
         required: true,
         callbacks: {
           "framework_controls is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Contains detailed information about all of the controls of a framework. Each framework must contain at least one control.
         DESCRIPTION

property :framework_description, String,
         callbacks: {
           "framework_description is not a String" => lambda { |v| v.is_a? String },
           "framework_description needs to be 0..1024 characters" => lambda { |v| v.length >= 0 && v.length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           An optional description of the framework with a maximum 1,024 characters.
         DESCRIPTION

property :framework_name, String,
         callbacks: {
           "framework_name is not a String" => lambda { |v| v.is_a? String },
           "framework_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "framework_name must match pattern [a-zA-Z][_a-zA-Z0-9]*" => lambda { |v| v =~ Regexp.new("/[a-zA-Z][_a-zA-Z0-9]*/") },
         },
         description: <<~'DESCRIPTION'
           The unique name of a framework. This name is between 1 and 256 characters, starting with a letter, and consisting of letters (a-z, A-Z), numbers (0-9), and underscores (_).
         DESCRIPTION

property :framework_tags, Array,
         callbacks: {
           "framework_tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Metadata that you can assign to help organize the frameworks that you create. Each tag is a key-value pair.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Backup::Framework"
rest_api_document "/AWS::Backup::Framework"

rest_property_map({
  framework_controls:    "FrameworkControls",
  framework_description: "FrameworkDescription",
  framework_name:        "FrameworkName",
  framework_tags:        "FrameworkTags",
})

rest_post_only_properties %i{
  framework_name
}
