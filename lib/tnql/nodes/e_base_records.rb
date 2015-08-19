module Tnql #:nodoc: all
  module Nodes
    module EBaseRecordsNode
      def meta_data_item
        filter =
          if types.empty?
            { Tnql::ALL => true }
          else
            { Tnql::EQUALS => types.to_list }
          end
        { 'unprocessed_records.sources' => filter }
      end
    end

    module BatchTypesNode
      def to_list
        allowed_types.to_list
      end
    end

    module AllowedTypesNode
      def to_list
        list = [batch_type.to_type]
        list.concat types.elements.map(&:extract_type)
      end
    end

    module MoreTypesNode
      def extract_type
        batch_type.to_type
      end
    end

    module ActionsNode
      def meta_data_item
        { 'action.actioninitiated' => { Tnql::EQUALS => action_type.text_value.upcase.strip } }
      end
    end

    module ActionProviderCodeNode
      def meta_data_item
        {
          'action.providercode' => { Tnql::EQUALS => code.text_value.upcase },
          'action.providertype' => { Tnql::EQUALS => provider_type.text_value.upcase }
        }
      end
    end

    module ActionProviderNameNode
      def meta_data_item
        {
          'action.providername' => { Tnql::BEGINS => short_desc.text_value.upcase },
          'action.providertype' => { Tnql::EQUALS => provider_type.text_value.upcase }
        }
      end
    end
  end
end
