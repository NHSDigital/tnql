module Tnql #:nodoc: all
  module Nodes
    module RegistryNode
      def meta_data_item
        registrycode = registry.to_registrycode
        exclude_crown_dependency = !exclude.blank? && exclude.to_registrycode == registrycode
        { 'tumour.registry' => { Tnql::EQUALS => [registrycode, exclude_crown_dependency] } }
      end
    end

    module ExcludeCrownDependencyNode
      CROWN_DEPENDENCY_REGISTRY = {
        'channel islands' => 'Y1001',
        'iom' => 'Y1701',
        'isle of man' => 'Y1701'
      }.freeze unless defined?(CROWN_DEPENDENCY_REGISTRY)

      def to_registrycode
        CROWN_DEPENDENCY_REGISTRY[crown_dependency.text_value]
      end
    end

    module RegistryCodeNode
      def to_registrycode
        text_value.upcase
      end
    end

    module RegistryAbbrNode
      REGISTRY_ABBR = {
        'nycris' => 'Y0201',
        'trent'  => 'Y0301',
        'ecric'  => 'Y0401',
        'thames' => 'Y0801',
        'oxford' => 'Y0901',
        'ociu'   => 'Y0901',
        'swcis'  => 'Y1001',
        'wmciu'  => 'Y1201',
        'nwcis'  => 'Y1701'
      }.freeze unless defined?(REGISTRY_ABBR)

      def to_registrycode
        REGISTRY_ABBR[text_value]
      end
    end
  end
end
