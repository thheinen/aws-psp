# Import API specifics
use "awscc_base"

resource_name :aws_appsync_source_api_association
provides :aws_appsync_source_api_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::AppSync::SourceApiAssociation
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Description of the SourceApiAssociation.
         DESCRIPTION

property :merged_api_identifier, String,
         callbacks: {
           "merged_api_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Identifier of the Merged GraphQLApi to associate. It could be either GraphQLApi ApiId or ARN
         DESCRIPTION

property :source_api_association_config, Hash,
         callbacks: {
           "Subproperty `MergeType` is not a String" => lambda { |v| v[:MergeType].is_a? String },
           "Subproperty `MergeType`is not one of `AUTO_MERGE`, `MANUAL_MERGE`" => lambda { |v| %w{AUTO_MERGE MANUAL_MERGE}.include? v[:MergeType] },
         },
         description: <<~'DESCRIPTION'
           Customized configuration for SourceApiAssociation.
         DESCRIPTION

property :source_api_identifier, String,
         callbacks: {
           "source_api_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Identifier of the Source GraphQLApi to associate. It could be either GraphQLApi ApiId or ARN
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::AppSync::SourceApiAssociation"
rest_api_document "/AWS::AppSync::SourceApiAssociation"

rest_property_map({
  description:                   "Description",
  merged_api_identifier:         "MergedApiIdentifier",
  source_api_association_config: "SourceApiAssociationConfig",
  source_api_identifier:         "SourceApiIdentifier",
})

rest_post_only_properties %i{
  merged_api_identifier source_api_identifier
}
