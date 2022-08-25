# Should go into Chef-Client Core to make REST APIs easier
class Chef
  module DSL
    module RestResourceAddon
      # RFC6570-Templated URL to store
      #alias_method :rest_api_store, :rest_api_document

      # Specify unique ID field in POST returns
      def rest_id_field(rest_id_field = NOT_PASSED)
        @rest_id_field = rest_id_field if rest_id_field != NOT_PASSED
        @rest_id_field
      end
    end
  end
end

Chef::DSL::Universal.include Chef::DSL::RestResourceAddon
