require_relative 'resource_base_generator'
require_relative 'serializers/rspec_dumper'
require 'puppet'
require 'puppet/pops'

module Retrospec
  module Puppet
    module Generators
      class AcceptanceGenerator < Retrospec::Puppet::Generators::ResourceBaseGenerator
        # retrospec will initilalize this class so its up to you
        # to set any additional variables you need to get the job done.
        def initialize(module_path, spec_object = {})
          super
          @singular_name = 'acceptance'
          @plural_name = 'acceptance'
        end

        def spec_template_file
          File.join('acceptance_spec_test.rb.retrospec.erb')
        end

        def spec_path
          File.join(module_path, 'spec', plural_name, 'classes')
        end

        def self.supported_types
          unless @supported_types
            @supported_types =
            [
              ::Puppet::Pops::Model::HostClassDefinition,
              ::Puppet::Pops::Model::ResourceTypeDefinition
            ]
          end
          @supported_types
        end

        def self.generate_spec_files(module_path, config_data)
          files = []
          manifest_files(module_path).each do |file|
            acceptance = new(module_path, config_data.merge({:manifest_file => file}))
            next unless supported_types.include?(acceptance.resource_type)
            files << acceptance.generate_spec_file
          end
          files
        end

      end

    end
  end
end
