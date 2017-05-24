module Tnql #:nodoc: all
  module Nodes
    module RegistryNode
      def meta_data_item
        { 'tumour.registry' => { Tnql::EQUALS => registry.to_registrycode } }
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
