# Import API specifics
use "awscc_base"

resource_name :aws_quicksight_analysis
provides :aws_quicksight_analysis, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of the AWS::QuickSight::Analysis Resource Type.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :analysis_id, String,
         required: true,
         callbacks: {
           "analysis_id is not a String" => lambda { |v| v.is_a? String },
           "analysis_id needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
           "analysis_id must match pattern [\w\-]+" => lambda { |v| v =~ Regexp.new("/[\w\-]+/") },
         },
         description: ""

property :aws_account_id, String,
         required: true,
         callbacks: {
           "aws_account_id is not a String" => lambda { |v| v.is_a? String },
           "aws_account_id needs to be 12..12 characters" => lambda { |v| v.length >= 12 && v.length <= 12 },
           "aws_account_id must match pattern ^[0-9]{12}$" => lambda { |v| v =~ Regexp.new("/^[0-9]{12}$/") },
         },
         description: ""

property :errors, Array,
         callbacks: {
           "errors is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "<p>Errors associated with the analysis.</p>"

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
           "name must match pattern [\u0020-\u00FF]+" => lambda { |v| v =~ Regexp.new("/[\u0020-\u00FF]+/") },
         },
         description: "<p>The descriptive name of the analysis.</p>"

property :parameters, Hash,
         callbacks: {
           "Subproperty `StringParameters` is not a Array" => lambda { |v| v[:StringParameters].is_a? Array },
           "Subproperty `DecimalParameters` is not a Array" => lambda { |v| v[:DecimalParameters].is_a? Array },
           "Subproperty `IntegerParameters` is not a Array" => lambda { |v| v[:IntegerParameters].is_a? Array },
           "Subproperty `DateTimeParameters` is not a Array" => lambda { |v| v[:DateTimeParameters].is_a? Array },
         },
         description: ""

property :permissions, Array,
         callbacks: {
           "permissions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           <p>A structure that describes the principals and the resource-level permissions on an
      analysis. You can use the <code>Permissions</code> structure to grant permissions by
      providing a list of AWS Identity and Access Management (IAM) action information for each
      principal listed by Amazon Resource Name (ARN). </p>
            <p>To specify no permissions, omit <code>Permissions</code>.</p>
         DESCRIPTION

property :source_entity, Hash,
         required: true,
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           <p>Contains a map of the key-value pairs for the resource tag or tags assigned to the
      analysis.</p>
         DESCRIPTION

property :theme_arn, String,
         callbacks: {
           "theme_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: "<p>The ARN of the theme of the analysis.</p>"

# API URLs and mappings
rest_api_collection "/AWS::QuickSight::Analysis"
rest_api_document "/AWS::QuickSight::Analysis"

rest_property_map({
  analysis_id:    "AnalysisId",
  aws_account_id: "AwsAccountId",
  errors:         "Errors",
  name:           "Name",
  parameters:     "Parameters",
  permissions:    "Permissions",
  source_entity:  "SourceEntity",
  tags:           "Tags",
  theme_arn:      "ThemeArn",
})

rest_post_only_properties %i{
  analysis_id aws_account_id
}
