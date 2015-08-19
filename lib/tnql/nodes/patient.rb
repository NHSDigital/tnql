module Tnql #:nodoc: all
  module Nodes
    module GenderNode
      def meta_data_item
        { 'patient.sex' => { Tnql::EQUALS => gender.text_value == 'male' ? '1' : '2' } }
      end
    end
  end
end
