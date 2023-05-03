# Import API specifics
use "awscc_base"

resource_name :aws_proton_environment_template
provides :aws_proton_environment_template, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::Proton::EnvironmentTemplate Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..500 characters" => lambda { |v| v.length >= 0 && v.length <= 500 },
         },
         description: <<~'DESCRIPTION'
           <p>A description of the environment template.</p>
         DESCRIPTION

property :display_name, String,
         callbacks: {
           "display_name is not a String" => lambda { |v| v.is_a? String },
           "display_name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
         },
         description: <<~'DESCRIPTION'
           <p>The environment template name as displayed in the developer interface.</p>
         DESCRIPTION

property :encryption_key, String,
         callbacks: {
           "encryption_key is not a String" => lambda { |v| v.is_a? String },
           "encryption_key needs to be 1..200 characters" => lambda { |v| v.length >= 1 && v.length <= 200 },
           "encryption_key must match pattern ^arn:(aws|aws-cn|aws-us-gov):[a-zA-Z0-9-]+:[a-zA-Z0-9-]*:\d{12}:([\w+=,.@-]+[/:])*[\w+=,.@-]+$" => lambda { |v| v =~ Regexp.new("/^arn:(aws|aws-cn|aws-us-gov):[a-zA-Z0-9-]+:[a-zA-Z0-9-]*:\d{12}:([\w+=,.@-]+[/:])*[\w+=,.@-]+$/") },
         },
         description: <<~'DESCRIPTION'
           <p>A customer provided encryption key that Proton uses to encrypt data.</p>
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "name must match pattern ^[0-9A-Za-z]+[0-9A-Za-z_\-]*$" => lambda { |v| v =~ Regexp.new("/^[0-9A-Za-z]+[0-9A-Za-z_\-]*$/") },
         },
         description: ""

property :provisioning, Hash,
         callbacks: {
           "provisioning is not a String" => lambda { |v| v.is_a? String },
           "provisioningis not one of `CUSTOMER_MANAGED`" => lambda { |v| %w{CUSTOMER_MANAGED}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           <p>An optional list of metadata items that you can associate with the Proton environment template. A tag is a key-value pair.</p>
      <p>For more information, see <a href="https://docs.aws.amazon.com/proton/latest/userguide/resources.html">Proton resources and tagging</a> in the
      <i>Proton User Guide</i>.</p>
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Proton::EnvironmentTemplate"
rest_api_document "/AWS::Proton::EnvironmentTemplate"

rest_property_map({
  description:    "Description",
  display_name:   "DisplayName",
  encryption_key: "EncryptionKey",
  name:           "Name",
  provisioning:   "Provisioning",
  tags:           "Tags",
})

rest_post_only_properties %i{
  encryption_key name provisioning
}
