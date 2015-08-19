module Tnql #:nodoc: all
  module Nodes
    module ProviderNameNode
      def meta_data_item
        # default to provider
        key = provider_type.text_value == 'cancer network' ? 'cn_ukacrname' : 'providername'
        { "diagnosis.#{key}" =>
          {
            Tnql::BEGINS => name.text_value.upcase,
            :interval => interval
          }
        }
      end
    end

    module ProviderCodeNode
      def meta_data_item
        # default to provider
        key = provider_type.text_value == 'cancer network' ? 'cn_ukacr' : 'providercode'
        { "diagnosis.#{key}" => { Tnql::EQUALS => code.text_value.upcase } }
      end
    end
  end
end
