# Import API specifics
use "awscc_base"

resource_name :aws_proton_environment_account_connection
provides :aws_proton_environment_account_connection, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Schema describing various properties for AWS Proton Environment Account Connections resources.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :codebuild_role_arn, String,
         callbacks: {
           "codebuild_role_arn is not a String" => lambda { |v| v.is_a? String },
           "codebuild_role_arn needs to be 1..200 characters" => lambda { |v| v.length >= 1 && v.length <= 200 },
           "codebuild_role_arn must match pattern ^arn:(aws|aws-cn|aws-us-gov):iam::\d{12}:role/([\w+=,.@-]{1,512}[/:])*([\w+=,.@-]{1,64})$" => lambda { |v| v =~ Regexp.new("/^arn:(aws|aws-cn|aws-us-gov):iam::\d{12}:role/([\w+=,.@-]{1,512}[/:])*([\w+=,.@-]{1,64})$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of an IAM service role in the environment account. AWS Proton uses this role to provision infrastructure resources using CodeBuild-based provisioning in the associated environment account.
         DESCRIPTION

property :component_role_arn, String,
         callbacks: {
           "component_role_arn is not a String" => lambda { |v| v.is_a? String },
           "component_role_arn needs to be 1..200 characters" => lambda { |v| v.length >= 1 && v.length <= 200 },
           "component_role_arn must match pattern ^arn:(aws|aws-cn|aws-us-gov):iam::\d{12}:role/([\w+=,.@-]{1,512}[/:])*([\w+=,.@-]{1,64})$" => lambda { |v| v =~ Regexp.new("/^arn:(aws|aws-cn|aws-us-gov):iam::\d{12}:role/([\w+=,.@-]{1,512}[/:])*([\w+=,.@-]{1,64})$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the IAM service role that AWS Proton uses when provisioning directly defined components in the associated environment account. It determines the scope of infrastructure that a component can provision in the account.
         DESCRIPTION

property :environment_account_id, String,
         callbacks: {
           "environment_account_id is not a String" => lambda { |v| v.is_a? String },
           "environment_account_id must match pattern ^\d{12}$" => lambda { |v| v =~ Regexp.new("/^\d{12}$/") },
         },
         description: <<~'DESCRIPTION'
           The environment account that's connected to the environment account connection.
         DESCRIPTION

property :environment_name, String,
         callbacks: {
           "environment_name is not a String" => lambda { |v| v.is_a? String },
           "environment_name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "environment_name must match pattern ^[0-9A-Za-z]+[0-9A-Za-z_\-]*$" => lambda { |v| v =~ Regexp.new("/^[0-9A-Za-z]+[0-9A-Za-z_\-]*$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the AWS Proton environment that's created in the associated management account.
         DESCRIPTION

property :management_account_id, String,
         callbacks: {
           "management_account_id is not a String" => lambda { |v| v.is_a? String },
           "management_account_id must match pattern ^\d{12}$" => lambda { |v| v =~ Regexp.new("/^\d{12}$/") },
         },
         description: <<~'DESCRIPTION'
           The ID of the management account that accepts or rejects the environment account connection. You create an manage the AWS Proton environment in this account. If the management account accepts the environment account connection, AWS Proton can use the associated IAM role to provision environment infrastructure resources in the associated environment account.
         DESCRIPTION

property :role_arn, String,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 1..200 characters" => lambda { |v| v.length >= 1 && v.length <= 200 },
           "role_arn must match pattern ^arn:(aws|aws-cn|aws-us-gov):iam::\d{12}:role/([\w+=,.@-]{1,512}[/:])*([\w+=,.@-]{1,64})$" => lambda { |v| v =~ Regexp.new("/^arn:(aws|aws-cn|aws-us-gov):iam::\d{12}:role/([\w+=,.@-]{1,512}[/:])*([\w+=,.@-]{1,64})$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the IAM service role that's created in the environment account. AWS Proton uses this role to provision infrastructure resources in the associated environment account.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           <p>An optional list of metadata items that you can associate with the Proton environment account connection. A tag is a key-value pair.</p>
      <p>For more information, see <a href="https://docs.aws.amazon.com/proton/latest/userguide/resources.html">Proton resources and tagging</a> in the
      <i>Proton User Guide</i>.</p>
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Proton::EnvironmentAccountConnection"
rest_api_document "/AWS::Proton::EnvironmentAccountConnection"

rest_property_map({
  codebuild_role_arn:     "CodebuildRoleArn",
  component_role_arn:     "ComponentRoleArn",
  environment_account_id: "EnvironmentAccountId",
  environment_name:       "EnvironmentName",
  management_account_id:  "ManagementAccountId",
  role_arn:               "RoleArn",
  tags:                   "Tags",
})

