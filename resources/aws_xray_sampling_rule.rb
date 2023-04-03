# Import API specifics
use "awscc_base"

resource_name :aws_xray_sampling_rule
provides :aws_xray_sampling_rule, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  This schema provides construct and validation rules for AWS-XRay SamplingRule resource parameters.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :rule_name, Hash,
         callbacks: {
           "rule_name is not a String" => lambda { |v| v.is_a? String },
           "rule_name needs to be 1..32 characters" => lambda { |v| v.length >= 1 && v.length <= 32 },
         },
         description: ""

property :sampling_rule, Hash,
         callbacks: {
           "Subproperty `Attributes` is not a Object" => lambda { |v| v[:Attributes].is_a? Object },
           "Subproperty `FixedRate` is not a Number" => lambda { |v| v[:FixedRate].is_a? Number },
           "Subproperty `Host` is not a String" => lambda { |v| v[:Host].is_a? String },
           "Subproperty `HTTPMethod` is not a String" => lambda { |v| v[:HTTPMethod].is_a? String },
           "Subproperty `Priority` is not a Integer" => lambda { |v| v[:Priority].is_a? Integer },
           "Subproperty `ReservoirSize` is not a Integer" => lambda { |v| v[:ReservoirSize].is_a? Integer },
           "Subproperty `ResourceARN` is not a String" => lambda { |v| v[:ResourceARN].is_a? String },
           "Subproperty `ServiceName` is not a String" => lambda { |v| v[:ServiceName].is_a? String },
           "Subproperty `ServiceType` is not a String" => lambda { |v| v[:ServiceType].is_a? String },
           "Subproperty `URLPath` is not a String" => lambda { |v| v[:URLPath].is_a? String },
           "Subproperty `Version` is not a Integer" => lambda { |v| v[:Version].is_a? Integer },
         },
         description: ""

property :sampling_rule_record, Hash,
         callbacks: {
           "Subproperty `CreatedAt` is not a String" => lambda { |v| v[:CreatedAt].is_a? String },
           "Subproperty `ModifiedAt` is not a String" => lambda { |v| v[:ModifiedAt].is_a? String },
         },
         description: ""

property :sampling_rule_update, Hash,
         callbacks: {
           "Subproperty `Attributes` is not a Object" => lambda { |v| v[:Attributes].is_a? Object },
           "Subproperty `FixedRate` is not a Number" => lambda { |v| v[:FixedRate].is_a? Number },
           "Subproperty `Host` is not a String" => lambda { |v| v[:Host].is_a? String },
           "Subproperty `HTTPMethod` is not a String" => lambda { |v| v[:HTTPMethod].is_a? String },
           "Subproperty `Priority` is not a Integer" => lambda { |v| v[:Priority].is_a? Integer },
           "Subproperty `ReservoirSize` is not a Integer" => lambda { |v| v[:ReservoirSize].is_a? Integer },
           "Subproperty `ResourceARN` is not a String" => lambda { |v| v[:ResourceARN].is_a? String },
           "Subproperty `ServiceName` is not a String" => lambda { |v| v[:ServiceName].is_a? String },
           "Subproperty `ServiceType` is not a String" => lambda { |v| v[:ServiceType].is_a? String },
           "Subproperty `URLPath` is not a String" => lambda { |v| v[:URLPath].is_a? String },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::XRay::SamplingRule"
rest_api_document "/AWS::XRay::SamplingRule"

rest_property_map({
  rule_name:            "RuleName",
  sampling_rule:        "SamplingRule",
  sampling_rule_record: "SamplingRuleRecord",
  sampling_rule_update: "SamplingRuleUpdate",
  tags:                 "Tags",
})

