# Import API specifics
use "awscc_base"

resource_name :aws_omics_run_group
provides :aws_omics_run_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::Omics::RunGroup Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :max_cpus, Number,
         callbacks: {
           "max_cpus is not a Number" => lambda { |v| v.is_a? Number },
         },
         description: ""

property :max_duration, Number,
         callbacks: {
           "max_duration is not a Number" => lambda { |v| v.is_a? Number },
         },
         description: ""

property :max_runs, Number,
         callbacks: {
           "max_runs is not a Number" => lambda { |v| v.is_a? Number },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "name must match pattern ^[\p{L}||\p{M}||\p{Z}||\p{S}||\p{N}||\p{P}]+$" => lambda { |v| v =~ Regexp.new("/^[\p{L}||\p{M}||\p{Z}||\p{S}||\p{N}||\p{P}]+$/") },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Omics::RunGroup"
rest_api_document "/AWS::Omics::RunGroup"

rest_property_map({
  max_cpus:     "MaxCpus",
  max_duration: "MaxDuration",
  max_runs:     "MaxRuns",
  name:         "Name",
  tags:         "Tags",
})

