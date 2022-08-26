# Import API specifics
use "awscc_base"

resource_name :aws_quicksight_template
provides :aws_quicksight_template, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of the AWS::QuickSight::Template Resource Type.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :aws_account_id, String,
         required: true,
         callbacks: {
           "aws_account_id is not a String" => lambda { |v| v.is_a? String },
           "aws_account_id needs to be 12..12 characters" => lambda { |v| v.length >= 12 && v.length <= 12 },
           "aws_account_id must match pattern ^[0-9]{12}$" => lambda { |v| v =~ Regexp.new("/^[0-9]{12}$/") },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
           "name must match pattern [\u0020-\u00FF]+" => lambda { |v| v =~ Regexp.new("/[\u0020-\u00FF]+/") },
         },
         description: "<p>A display name for the template.</p>"

property :permissions, Array,
         callbacks: {
           "permissions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "<p>A list of resource permissions to be set on the template. </p>"

property :source_entity, Hash,
         required: true,
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "<p>Contains a map of the key-value pairs for the resource tag or tags assigned to the resource.</p>"

property :template_id, String,
         required: true,
         callbacks: {
           "template_id is not a String" => lambda { |v| v.is_a? String },
           "template_id needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
           "template_id must match pattern [\w\-]+" => lambda { |v| v =~ Regexp.new("/[\w\-]+/") },
         },
         description: ""

property :version_description, String,
         callbacks: {
           "version_description is not a String" => lambda { |v| v.is_a? String },
           "version_description needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
         },
         description: <<~'DESCRIPTION'
           <p>A description of the current template version being created. This API operation creates the
      first version of the template. Every time <code>UpdateTemplate</code> is called, a new
      version is created. Each version of the template maintains a description of the version
      in the <code>VersionDescription</code> field.</p>
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::QuickSight::Template"
rest_api_document "/AWS::QuickSight::Template"

rest_property_map({
  aws_account_id:      "AwsAccountId",
  name:                "Name",
  permissions:         "Permissions",
  source_entity:       "SourceEntity",
  tags:                "Tags",
  template_id:         "TemplateId",
  version_description: "VersionDescription",
})

rest_post_only_properties %i{
  aws_account_id template_id
}
