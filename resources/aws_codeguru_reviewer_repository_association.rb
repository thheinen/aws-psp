# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_codeguru_reviewer_repository_association
provides :aws_codeguru_reviewer_repository_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  This resource schema represents the RepositoryAssociation resource in the Amazon CodeGuru Reviewer service.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :bucket_name, String,
         callbacks: {
           "bucket_name is not a String" => lambda { |v| v.is_a? String },
           "bucket_name needs to be 3..63 characters" => lambda { |v| v.length >= 3 && v.length <= 63 },
           "bucket_name must match pattern ^\S(.*\S)?$" => lambda { |v| v =~ Regexp.new("/^\S(.*\S)?$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the S3 bucket associated with an associated S3 repository. It must start with `codeguru-reviewer-`.
         DESCRIPTION

property :connection_arn, String,
         callbacks: {
           "connection_arn is not a String" => lambda { |v| v.is_a? String },
           "connection_arn needs to be 0..256 characters" => lambda { |v| v.length >= 0 && v.length <= 256 },
           "connection_arn must match pattern arn:aws(-[\w]+)*:.+:.+:[0-9]{12}:.+" => lambda { |v| v =~ Regexp.new("/arn:aws(-[\w]+)*:.+:.+:[0-9]{12}:.+/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of an AWS CodeStar Connections connection.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "name must match pattern ^\S[\w.-]*$" => lambda { |v| v =~ Regexp.new("/^\S[\w.-]*$/") },
         },
         description: <<~'DESCRIPTION'
           Name of the repository to be associated.
         DESCRIPTION

property :owner, String,
         callbacks: {
           "owner is not a String" => lambda { |v| v.is_a? String },
           "owner needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "owner must match pattern ^\S(.*\S)?$" => lambda { |v| v =~ Regexp.new("/^\S(.*\S)?$/") },
         },
         description: <<~'DESCRIPTION'
           The owner of the repository. For a Bitbucket repository, this is the username for the account that owns the repository.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags associated with a repository association.
         DESCRIPTION

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `CodeCommit`, `Bitbucket`, `GitHubEnterpriseServer`, `S3Bucket`" => lambda { |v| %w{CodeCommit Bitbucket GitHubEnterpriseServer S3Bucket}.include? v },
         },
         description: <<~'DESCRIPTION'
           The type of repository to be associated.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CodeGuruReviewer::RepositoryAssociation"
rest_api_document "/AWS::CodeGuruReviewer::RepositoryAssociation"

rest_property_map({
  bucket_name:    "BucketName",
  connection_arn: "ConnectionArn",
  name:           "Name",
  owner:          "Owner",
  tags:           "Tags",
  type:           "Type",
})

rest_post_only_properties %i{
  bucket_name connection_arn name owner tags type
}
