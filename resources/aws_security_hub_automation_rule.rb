# Import API specifics
use "awscc_base"

resource_name :aws_security_hub_automation_rule
provides :aws_security_hub_automation_rule, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::SecurityHub::AutomationRule resource represents the Automation Rule in your account. One rule resource is created for each Automation Rule in which you configure rule criteria and actions.


DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :actions, Array,
         callbacks: {
           "actions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :criteria, Hash,
         callbacks: {
           "Subproperty `ProductArn` is not a Array" => lambda { |v| v[:ProductArn].is_a? Array },
           "Subproperty `AwsAccountId` is not a Array" => lambda { |v| v[:AwsAccountId].is_a? Array },
           "Subproperty `Id` is not a Array" => lambda { |v| v[:Id].is_a? Array },
           "Subproperty `GeneratorId` is not a Array" => lambda { |v| v[:GeneratorId].is_a? Array },
           "Subproperty `Type` is not a Array" => lambda { |v| v[:Type].is_a? Array },
           "Subproperty `FirstObservedAt` is not a Array" => lambda { |v| v[:FirstObservedAt].is_a? Array },
           "Subproperty `LastObservedAt` is not a Array" => lambda { |v| v[:LastObservedAt].is_a? Array },
           "Subproperty `CreatedAt` is not a Array" => lambda { |v| v[:CreatedAt].is_a? Array },
           "Subproperty `UpdatedAt` is not a Array" => lambda { |v| v[:UpdatedAt].is_a? Array },
           "Subproperty `Confidence` is not a Array" => lambda { |v| v[:Confidence].is_a? Array },
           "Subproperty `Criticality` is not a Array" => lambda { |v| v[:Criticality].is_a? Array },
           "Subproperty `Title` is not a Array" => lambda { |v| v[:Title].is_a? Array },
           "Subproperty `Description` is not a Array" => lambda { |v| v[:Description].is_a? Array },
           "Subproperty `SourceUrl` is not a Array" => lambda { |v| v[:SourceUrl].is_a? Array },
           "Subproperty `ProductName` is not a Array" => lambda { |v| v[:ProductName].is_a? Array },
           "Subproperty `CompanyName` is not a Array" => lambda { |v| v[:CompanyName].is_a? Array },
           "Subproperty `SeverityLabel` is not a Array" => lambda { |v| v[:SeverityLabel].is_a? Array },
           "Subproperty `ResourceType` is not a Array" => lambda { |v| v[:ResourceType].is_a? Array },
           "Subproperty `ResourceId` is not a Array" => lambda { |v| v[:ResourceId].is_a? Array },
           "Subproperty `ResourcePartition` is not a Array" => lambda { |v| v[:ResourcePartition].is_a? Array },
           "Subproperty `ResourceRegion` is not a Array" => lambda { |v| v[:ResourceRegion].is_a? Array },
           "Subproperty `ResourceTags` is not a Array" => lambda { |v| v[:ResourceTags].is_a? Array },
           "Subproperty `ResourceDetailsOther` is not a Array" => lambda { |v| v[:ResourceDetailsOther].is_a? Array },
           "Subproperty `ComplianceStatus` is not a Array" => lambda { |v| v[:ComplianceStatus].is_a? Array },
           "Subproperty `ComplianceSecurityControlId` is not a Array" => lambda { |v| v[:ComplianceSecurityControlId].is_a? Array },
           "Subproperty `ComplianceAssociatedStandardsId` is not a Array" => lambda { |v| v[:ComplianceAssociatedStandardsId].is_a? Array },
           "Subproperty `VerificationState` is not a Array" => lambda { |v| v[:VerificationState].is_a? Array },
           "Subproperty `WorkflowStatus` is not a Array" => lambda { |v| v[:WorkflowStatus].is_a? Array },
           "Subproperty `RecordState` is not a Array" => lambda { |v| v[:RecordState].is_a? Array },
           "Subproperty `RelatedFindingsProductArn` is not a Array" => lambda { |v| v[:RelatedFindingsProductArn].is_a? Array },
           "Subproperty `RelatedFindingsId` is not a Array" => lambda { |v| v[:RelatedFindingsId].is_a? Array },
           "Subproperty `NoteText` is not a Array" => lambda { |v| v[:NoteText].is_a? Array },
           "Subproperty `NoteUpdatedAt` is not a Array" => lambda { |v| v[:NoteUpdatedAt].is_a? Array },
           "Subproperty `NoteUpdatedBy` is not a Array" => lambda { |v| v[:NoteUpdatedBy].is_a? Array },
           "Subproperty `UserDefinedFields` is not a Array" => lambda { |v| v[:UserDefinedFields].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The rule criteria for evaluating findings
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           Rule description
         DESCRIPTION

property :is_terminal, [TrueClass, FalseClass],
         callbacks: {
           "is_terminal is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           If Rule is a terminal rule
         DESCRIPTION

property :rule_name, String,
         callbacks: {
           "rule_name is not a String" => lambda { |v| v.is_a? String },
           "rule_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
         },
         description: <<~'DESCRIPTION'
           Rule name
         DESCRIPTION

property :rule_order, Integer,
         callbacks: {
           "rule_order is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Rule order value
         DESCRIPTION

property :rule_status, String,
         callbacks: {
           "rule_status is not a String" => lambda { |v| v.is_a? String },
           "rule_statusis not one of `ENABLED`, `DISABLED`" => lambda { |v| %w{ENABLED DISABLED}.include? v },
         },
         description: <<~'DESCRIPTION'
           Status of the Rule upon creation
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::SecurityHub::AutomationRule"
rest_api_document "/AWS::SecurityHub::AutomationRule"

rest_property_map({
  actions:     "Actions",
  criteria:    "Criteria",
  description: "Description",
  is_terminal: "IsTerminal",
  rule_name:   "RuleName",
  rule_order:  "RuleOrder",
  rule_status: "RuleStatus",
  tags:        "Tags",
})

