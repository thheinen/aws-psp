# Import API specifics
use "awscc_base"

resource_name :aws_connect_view_version
provides :aws_connect_view_version, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Connect::ViewVersion
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :version_description, String,
         callbacks: {
           "version_description is not a String" => lambda { |v| v.is_a? String },
           "version_description needs to be 1..4096 characters" => lambda { |v| v.length >= 1 && v.length <= 4096 },
           "version_description must match pattern ^([\p{L}\p{N}_.:\/=+\-@,]+[\p{L}\p{Z}\p{N}_.:\/=+\-@,]*)$" => lambda { |v| v =~ Regexp.new("/^([\p{L}\p{N}_.:\/=+\-@,]+[\p{L}\p{Z}\p{N}_.:\/=+\-@,]*)$/") },
         },
         description: <<~'DESCRIPTION'
           The description for the view version.
         DESCRIPTION

property :view_arn, String,
         required: true,
         callbacks: {
           "view_arn is not a String" => lambda { |v| v.is_a? String },
           "view_arn needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "view_arn must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*/view/[-:a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*/view/[-:a-zA-Z0-9]*$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the view for which a version is being created.
         DESCRIPTION

property :view_content_sha256, String,
         callbacks: {
           "view_content_sha256 is not a String" => lambda { |v| v.is_a? String },
           "view_content_sha256 needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "view_content_sha256 must match pattern ^[a-zA-Z0-9]{64}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9]{64}$/") },
         },
         description: <<~'DESCRIPTION'
           The view content hash to be checked.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Connect::ViewVersion"
rest_api_document "/AWS::Connect::ViewVersion"

rest_property_map({
  version_description: "VersionDescription",
  view_arn:            "ViewArn",
  view_content_sha256: "ViewContentSha256",
})

rest_post_only_properties %i{
  version_description view_arn view_content_sha256
}
