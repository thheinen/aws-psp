# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_personalize_solution
provides :aws_personalize_solution, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Personalize::Solution.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :dataset_group_arn, String,
         required: true,
         callbacks: {
           "dataset_group_arn is not a String" => lambda { |v| v.is_a? String },
           "dataset_group_arn must match pattern arn:([a-z\d-]+):personalize:.*:.*:.+" => lambda { |v| v =~ Regexp.new("/arn:([a-z\d-]+):personalize:.*:.*:.+/") },
         },
         description: <<~'DESCRIPTION'
           The ARN of the dataset group that provides the training data.
         DESCRIPTION

property :event_type, String,
         callbacks: {
           "event_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           When your have multiple event types (using an EVENT_TYPE schema field), this parameter specifies which event type (for example, 'click' or 'like') is used for training the model. If you do not provide an eventType, Amazon Personalize will use all interactions for training with equal weight regardless of type.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "name must match pattern ^[a-zA-Z0-9][a-zA-Z0-9\-_]*" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9][a-zA-Z0-9\-_]*/") },
         },
         description: <<~'DESCRIPTION'
           The name for the solution
         DESCRIPTION

property :perform_auto_ml, [TrueClass, FalseClass],
         callbacks: {
           "perform_auto_ml is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Whether to perform automated machine learning (AutoML). The default is false. For this case, you must specify recipeArn.
         DESCRIPTION

property :perform_hpo, [TrueClass, FalseClass],
         callbacks: {
           "perform_hpo is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Whether to perform hyperparameter optimization (HPO) on the specified or selected recipe. The default is false. When performing AutoML, this parameter is always true and you should not set it to false.
         DESCRIPTION

property :recipe_arn, String,
         callbacks: {
           "recipe_arn is not a String" => lambda { |v| v.is_a? String },
           "recipe_arn must match pattern arn:([a-z\d-]+):personalize:.*:.*:.+" => lambda { |v| v =~ Regexp.new("/arn:([a-z\d-]+):personalize:.*:.*:.+/") },
         },
         description: <<~'DESCRIPTION'
           The ARN of the recipe to use for model training. Only specified when performAutoML is false.
         DESCRIPTION

property :solution_config, Hash,
         callbacks: {
           "Subproperty `AlgorithmHyperParameters` is not a Object" => lambda { |v| v[:AlgorithmHyperParameters].is_a? Object },
           "Subproperty `AutoMLConfig` is not a Object" => lambda { |v| v[:AutoMLConfig].is_a? Object },
           "Subproperty `EventValueThreshold` is not a String" => lambda { |v| v[:EventValueThreshold].is_a? String },
           "Subproperty `FeatureTransformationParameters` is not a Object" => lambda { |v| v[:FeatureTransformationParameters].is_a? Object },
           "Subproperty `HpoConfig` is not a Object" => lambda { |v| v[:HpoConfig].is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Personalize::Solution"
rest_api_document "/AWS::Personalize::Solution"

rest_property_map({
  dataset_group_arn: "DatasetGroupArn",
  event_type:        "EventType",
  name:              "Name",
  perform_auto_ml:   "PerformAutoML",
  perform_hpo:       "PerformHPO",
  recipe_arn:        "RecipeArn",
  solution_config:   "SolutionConfig",
})

rest_post_only_properties %i{
  dataset_group_arn event_type name perform_auto_ml perform_hpo recipe_arn solution_config
}
