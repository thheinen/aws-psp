require 'json'

# Should go into Chef-Client Core to make REST APIs easier
module RestHelpers
  module UID
    ## REST ID (UID) Mapping Logic

    # Will only do "injective mapping", which means Chef holds the authorative
    # list of managed resources (chef resource name <-> API ID). This is because
    # sometimes APIs allow resources to be configured absolutely identical.
    def rest_id(named_resource = nil)
      load_rest_id

      cookbook = cookbook_name
      resource = current_resource.to_s unless named_resource

      node.dig(MAPPING_ATTRIBUTE, cookbook_name, named_resource || resource)
    end

    private

    MAPPING_ATTRIBUTE = 'rest_mappings'.freeze

    def load_rest_id
      if chef_zero?
        load_rest_id_mappings_file
      else
        load_rest_id_from_server
      end
    end

    def save_rest_id(id, prevent_overwrite: false)
      node.automatic[MAPPING_ATTRIBUTE] = {} unless node.key? MAPPING_ATTRIBUTE
      node.automatic[MAPPING_ATTRIBUTE][cookbook_name] = {} unless node.dig(MAPPING_ATTRIBUTE).key? cookbook_name

      if prevent_overwrite && !node[MAPPING_ATTRIBUTE][cookbook_name][current_resource.to_s].nil?
        logger.fatal "Attempt to overwrite UID mapping for #{cookbook_name}/#{current_resource}"
        raise
      end

      node.automatic[MAPPING_ATTRIBUTE][cookbook_name][current_resource.to_s] = id

      persist_rest_id_mapping
    end

    def remove_rest_id
      node.automatic[MAPPING_ATTRIBUTE][cookbook_name].delete(current_resource.to_s)

      persist_rest_id_mapping
    end

    def persist_rest_id_mapping
      if chef_zero?
        save_rest_id_mappings_file
      else
        node.save
      end
    end

    ## Chef Zero Support for UID Mapping

    def save_rest_id_mappings_file
      ::File.write(rest_id_mappings_file, JSON.dump(node[MAPPING_ATTRIBUTE]))
    end

    def load_rest_id_mappings_file
      return if node.key? MAPPING_ATTRIBUTE
      return unless File.exist?(rest_id_mappings_file)

      node.default[MAPPING_ATTRIBUTE] = JSON.parse IO.read(rest_id_mappings_file)
    end

    def rest_id_mappings_file
      name = ::File.join(Chef::Config[:file_cache_path], 'mappings.json')
    end

    def warn_once_on_chefzero
      return unless chef_zero?
      return if @warned

      logger.warn "Mapping data on local runs will be saved in #{Chef::Config[:file_cache_path]} only."

      @warned = true
    end

    def chef_zero?
      Chef.run_context.rest.url.start_with? 'chefzero://'
    end

    ## Chef Infra Server

    def load_rest_id_from_server
      settings = Chef::ServerAPI.new(Chef::Config[:chef_server_url]).get("nodes/#{node.name}").dig('automatic', MAPPING_ATTRIBUTE)
      node.automatic[MAPPING_ATTRIBUTE] = settings
    end
  end
end

Chef::DSL::Universal.include RestHelpers::UID
