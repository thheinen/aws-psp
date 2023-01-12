# Import API specifics
use "awscc_base"

resource_name :aws_auditmanager_assessment
provides :aws_auditmanager_assessment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An entity that defines the scope of audit evidence collected by AWS Audit Manager.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :assessment_reports_destination, Hash,
         description: ""

property :aws_account, Hash,
         description: ""

property :delegations, Array,
         callbacks: {
           "delegations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of delegations.
         DESCRIPTION

property :description, Hash,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :framework_id, Hash,
         callbacks: {
           "framework_id is not a String" => lambda { |v| v.is_a? String },
           "framework_id needs to be 32..36 characters" => lambda { |v| v.length >= 32 && v.length <= 36 },
           "framework_id must match pattern ^([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}|.*\S.*)$" => lambda { |v| v =~ Regexp.new("/^([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}|.*\S.*)$/") },
         },
         description: ""

property :name, Hash,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..127 characters" => lambda { |v| v.length >= 1 && v.length <= 127 },
           "name must match pattern ^[a-zA-Z0-9-_\.]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-_\.]+$/") },
         },
         description: ""

property :roles, Array,
         callbacks: {
           "roles is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of roles for the specified assessment.
         DESCRIPTION

property :scope, Hash,
         callbacks: {
           "Subproperty `AwsAccounts` is not a Array" => lambda { |v| v[:AwsAccounts].is_a? Array },
           "Subproperty `AwsServices` is not a Array" => lambda { |v| v[:AwsServices].is_a? Array },
         },
         description: ""

property :status, Hash,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
           "statusis not one of `ACTIVE`, `INACTIVE`" => lambda { |v| %w{ACTIVE INACTIVE}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags associated with the assessment.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::AuditManager::Assessment"
rest_api_document "/AWS::AuditManager::Assessment"

rest_property_map({
  assessment_reports_destination: "AssessmentReportsDestination",
  aws_account:                    "AwsAccount",
  delegations:                    "Delegations",
  description:                    "Description",
  framework_id:                   "FrameworkId",
  name:                           "Name",
  roles:                          "Roles",
  scope:                          "Scope",
  status:                         "Status",
  tags:                           "Tags",
})

rest_post_only_properties %i{
  aws_account framework_id
}
