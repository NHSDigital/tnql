require 'active_support/core_ext/object/blank'

module Tnql #:nodoc: all
  module Nodes
    module RecordCountNode
      def meta_data_item
        { 'limit' => { Tnql::EQUALS => number.text_value.to_i } }
      end
    end
  end
end
