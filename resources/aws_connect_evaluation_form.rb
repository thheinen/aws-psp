# Import API specifics
use "awscc_base"

resource_name :aws_connect_evaluation_form
provides :aws_connect_evaluation_form, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Connect::EvaluationForm
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of the evaluation form.
         DESCRIPTION

property :instance_arn, String,
         required: true,
         callbacks: {
           "instance_arn is not a String" => lambda { |v| v.is_a? String },
           "instance_arn must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the instance.
         DESCRIPTION

property :items, Array,
         required: true,
         callbacks: {
           "items is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of evaluation form items.
         DESCRIPTION

property :scoring_strategy, Hash,
         callbacks: {
           "Subproperty `Mode` is not a String" => lambda { |v| v[:Mode].is_a? String },
           "Subproperty `Mode`is not one of `QUESTION_ONLY`, `SECTION_ONLY`" => lambda { |v| %w{QUESTION_ONLY SECTION_ONLY}.include? v[:Mode] },
           "Subproperty `Status` is not a String" => lambda { |v| v[:Status].is_a? String },
           "Subproperty `Status`is not one of `ENABLED`, `DISABLED`" => lambda { |v| %w{ENABLED DISABLED}.include? v[:Status] },
         },
         description: <<~'DESCRIPTION'
           The scoring strategy.
         DESCRIPTION

property :status, String,
         required: true,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
           "statusis not one of `DRAFT`, `ACTIVE`" => lambda { |v| %w{DRAFT ACTIVE}.include? v },
         },
         description: <<~'DESCRIPTION'
           The status of the evaluation form.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           One or more tags.
         DESCRIPTION

property :title, String,
         required: true,
         callbacks: {
           "title is not a String" => lambda { |v| v.is_a? String },
           "title needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
         },
         description: <<~'DESCRIPTION'
           The title of the evaluation form.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Connect::EvaluationForm"
rest_api_document "/AWS::Connect::EvaluationForm"

rest_property_map({
  description:      "Description",
  instance_arn:     "InstanceArn",
  items:            "Items",
  scoring_strategy: "ScoringStrategy",
  status:           "Status",
  tags:             "Tags",
  title:            "Title",
})

