# Import API specifics
use "awscc_base"

resource_name :aws_ses_template
provides :aws_ses_template, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SES::Template
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :template, Hash,
         callbacks: {
           "Subproperty `TemplateName` is not a String" => lambda { |v| v[:TemplateName].is_a? String },
           "Subproperty `TemplateName` needs to be 1..64 characters" => lambda { |v| v[:TemplateName].length >= 1 && v[:TemplateName].length <= 64 },
           "Subproperty `TemplateName` must match pattern ^[a-zA-Z0-9_-]{1,64}$" => lambda { |v| v[:TemplateName] =~ Regexp.new("/^[a-zA-Z0-9_-]{1,64}$/") },
           "Subproperty `SubjectPart` is not a String" => lambda { |v| v[:SubjectPart].is_a? String },
           "Subproperty `TextPart` is not a String" => lambda { |v| v[:TextPart].is_a? String },
           "Subproperty `HtmlPart` is not a String" => lambda { |v| v[:HtmlPart].is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::SES::Template"
rest_api_document "/AWS::SES::Template"

rest_property_map({
  template: "Template",
})

rest_post_only_properties %i{
  template/template_name
}
