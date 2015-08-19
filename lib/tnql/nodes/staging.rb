module Tnql #:nodoc: all
  module Nodes
    module StageDetailNode
      def meta_data_item
        case text_value
        when 'unstaged'
          { 'staging.stage' => { Tnql::EQUALS => nil } }
        when 'valid stage'
          { 'staging.stage' => { Tnql::BEGINS => %w(1 2 3 4) } }
        else
          stage_values = stages.elements.map(&:text_value).map(&:upcase)
          { 'staging.stage' => { Tnql::BEGINS => stage_values } }
        end
      end
    end
  end
end
