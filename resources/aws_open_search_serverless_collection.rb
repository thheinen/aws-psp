# Import API specifics
use "awscc_base"

resource_name :aws_open_search_serverless_collection
provides :aws_open_search_serverless_collection, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Amazon OpenSearchServerless collection resource
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of the collection
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 3..32 characters" => lambda { |v| v.length >= 3 && v.length <= 32 },
           "name must match pattern ^[a-z][a-z0-9-]{2,31}$" => lambda { |v| v =~ Regexp.new("/^[a-z][a-z0-9-]{2,31}$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the collection.
            The name must meet the following criteria:
      Unique to your account and AWS Region
      Starts with a lowercase letter
      Contains only lowercase letters a-z, the numbers 0-9 and the hyphen (-)
      Contains between 3 and 32 characters

         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           List of tags to be added to the resource
         DESCRIPTION

property :type, Hash,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `SEARCH`, `TIMESERIES`, `VECTORSEARCH`" => lambda { |v| %w{SEARCH TIMESERIES VECTORSEARCH}.include? v },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::OpenSearchServerless::Collection"
rest_api_document "/AWS::OpenSearchServerless::Collection"

rest_property_map({
  description: "Description",
  name:        "Name",
  tags:        "Tags",
  type:        "Type",
})

rest_post_only_properties %i{
  name tags type
}
